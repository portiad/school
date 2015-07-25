/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {

	@IBOutlet var dataTable: UITableView!
	@IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var scroller: HorizontalScroller!
    
    private var allAlbums = [Album]()
    private var currentAlbumData : (titles:[String], values:[String])?
    private var currentAlbumIndex = 0
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        //Turn off translucency on the navigation bar.
        self.navigationController?.navigationBar.translucent = false
        currentAlbumIndex = 0
        
        //Get a list of all the albums via the API. Remember, the plan is to use the facade of LibraryAPI rather than PersistencyManager directly!
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        
        // This is where you setup the UITableView. You declare that the view controller is the UITableView delegate/data source; therefore, all the information required by UITableView will be provided by the view controller. Note that you can actually set the delegate and datasource in a storyboard, if your table view is created there.
        // the uitableview that presents the album data
        dataTable.delegate =  self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        view.addSubview(dataTable!)
        
        self.showDataForAlbum(currentAlbumIndex)
        loadPreviousState()
        
        scroller.delegate = self
        reloadScroller()
        
        //iOS sends a UIApplicationDidEnterBackgroundNotification notification when the app enters the background. You can use this notification to call saveCurrentState.
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"saveCurrentState", name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func initialViewIndex(scroller: HorizontalScroller) -> Int {
        return currentAlbumIndex
    }
    
    func showDataForAlbum(albumIndex: Int) {
        // defensive code: make sure the requested index is lower than the amount of albums
        if (albumIndex < allAlbums.count && albumIndex > -1) {
            //fetch the album
            let album = allAlbums[albumIndex]
            // save the albums data to present it later in the tableview
            currentAlbumData = album.ae_tableRepresentation()
        } else {
            currentAlbumData = nil
        }
        // we have the data we need, let's refresh our tableview
        dataTable!.reloadData()
    }
    
    func reloadScroller() {
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        
        if currentAlbumIndex < 0 {
            currentAlbumIndex = 0
        } else if currentAlbumIndex < allAlbums.count {
            currentAlbumIndex = allAlbums.count - 1
        }
        scroller.reload()
        showDataForAlbum(currentAlbumIndex)
    }
}

// MARK: Extensions

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albumData = currentAlbumData {
            return albumData.titles.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        if let albumData = currentAlbumData {
            cell.textLabel!.text = albumData.titles[indexPath.row]
            cell.detailTextLabel!.text = albumData.values[indexPath.row]
        }
        return cell
    }
    
    //MARK: Memento Pattern
    //saveCurrentState saves the current album index to NSUserDefaults – NSUserDefaults is a standard data store provided by iOS for saving application specific settings and data.
    func saveCurrentState() {
        // When the user leaves the app and then comes back again, he wants it to be in the exact same state
        // he left it. In order to do this we need to save the currently displayed album.
        // Since it's only one piece of information we can use NSUserDefaults.
        NSUserDefaults.standardUserDefaults().setInteger(currentAlbumIndex, forKey: "currentAlbumIndex")
    }
    
    func loadPreviousState() {
        currentAlbumIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentAlbumIndex")
        showDataForAlbum(currentAlbumIndex)
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: HorizontalScrollerDelegate {
    // ask the delegate how many views he wants to present inside the horizontal scroller
    func numberOfViewsForHorizontalScroller(scroller: HorizontalScroller) -> Int {
        return allAlbums.count
    }
    
    // ask the delegate to return the view that should appear at <index>
    func horizontalScrollerViewAtIndex(scroller: HorizontalScroller, index:Int) -> UIView {
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), albumCover: album.coverUrl)
        if currentAlbumIndex == index {
            albumView.highlightAlbum(didHighlightView: true)
        } else {
            albumView.highlightAlbum(didHighlightView: false)
        }
        return albumView
    }
    
    // inform the delegate what the view at <index> has been clicked
    func horizontalScrollerClickedViewAtIndex(scroller: HorizontalScroller, index:Int) {
        //First you grab the previously selected album, and deselect the album cover.
        let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(didHighlightView: false)
        
        //Store the current album cover index you just clicked
        currentAlbumIndex = index
        
        //Grab the album cover that is currently selected and highlight the selection.
        let albumView = scroller.viewAtIndex(index) as! AlbumView
        albumView.highlightAlbum(didHighlightView: true)
        
        //Display the data for the new album within the table view.
        showDataForAlbum(index)
    }
    
    // ask the delegate for the index of the initial view to display. this method is optional
    // and defaults to 0 if it's not implemented by the delegate
}