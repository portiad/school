//
//  FilterViewController.swift
//  ExchangeAGram
//
//  Created by Portia Dean on 4/17/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var thisFeedItem: FeedItem!
    var collectionView: UICollectionView!
    var filters: [CIFilter] = []
    var context: CIContext = CIContext(options: nil)
    
    let kIntensity = 0.7
    let kPlaceHolderImage = UIImage(named: "Placeholder")
    let kTemp = NSTemporaryDirectory()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let layout = UICollectionViewFlowLayout()
        // boarders & sizes
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150.0, height: 150.0)
        //initialize the instance
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.registerClass(FilterCell.self, forCellWithReuseIdentifier: "MyCell")
        filters = photoFilters()
        
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //required fuctions to add in (collectionView.dataSource = self, collectionView.delegate = self)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:FilterCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! FilterCell
    
        cell.imageView.image = kPlaceHolderImage
        
        // Background queue for the filters to take away from the main queue (multi threaded)
        let filterQueue: dispatch_queue_t = dispatch_queue_create("filter queue", nil)
        dispatch_async(filterQueue, { () -> Void in
            let filterImage = self.getCacheImage(indexPath.row)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.imageView.image = filterImage
            })
        })
        
        return cell
    }
    
    //UICollectionViewDelegate
    
    //saving filtered image as the new image
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        createUIAlertController(indexPath)

    }
    
    //Helper Functions: UICollectionViewDataSource
    
    func photoFilters() -> [CIFilter] {
        let blur = CIFilter(name: "CIGaussianBlur")
        let instant = CIFilter(name: "CIPhotoEffectInstant")
        let noir = CIFilter(name: "CIPhotoEffectNoir")
        let transfer = CIFilter(name: "CIPhotoEffectTransfer")
        let unsharpen = CIFilter(name: "CIUnsharpMask")
        let monochrome = CIFilter(name: "CIColorMonochrome")
        
        let colorControls = CIFilter(name: "CIColorControls")
        colorControls.setValue(0.5, forKey: kCIInputSaturationKey)
        
        let sepia = CIFilter(name: "CISepiaTone")
        sepia.setValue(kIntensity, forKey: kCIInputIntensityKey)
        
        //modifying color values in a range
        let colorClamp = CIFilter(name: "CIColorClamp")
        colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents")
        colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
        
        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite.setValue(sepia.outputImage, forKey: kCIInputImageKey)
        
        let vignette = CIFilter(name: "CIVignette")
        vignette.setValue(composite.outputImage, forKey: kCIInputImageKey)
        vignette.setValue(kIntensity * 2, forKey: kCIInputIntensityKey)
        vignette.setValue(kIntensity * 30, forKey: kCIInputRadiusKey) //distance from center for change
        
        
        return [blur, noir, transfer, unsharpen, monochrome, colorControls, sepia, colorClamp, composite, vignette]
    }
    
    //Image Data and CIFilter instance spit back UIImage
    func filteredImageFromImage(imageData:NSData, filter: CIFilter) -> UIImage {
        let unfilteredImage = CIImage(data: imageData)
        filter.setValue(unfilteredImage, forKey: kCIInputImageKey)
        let filteredImage:CIImage = filter.outputImage
        
        // optimzed the main queue to allow filters to be applied to image
        let extent = filteredImage.extent()
        let cgImage: CGImageRef = context.createCGImage(filteredImage, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
    
        return finalImage!
    }
    
    // UIAlertController Helper Functions
    func createUIAlertController(indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Photo Options", message: "Please choose an option", preferredStyle: UIAlertControllerStyle.Alert)
        
        // adding in a text field
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add caption!"
            textField.secureTextEntry = false
        }
        
        let textField = alert.textFields![0] as! UITextField
        var text = textField.text
        
        let photoAction = UIAlertAction(title: "Post Photo to Facebook with Caption", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in
            
            self.saveFilterToCoreData(indexPath, caption: text)
            self.shareToFacebook(indexPath)
        }
        alert.addAction(photoAction)
        
        let saveFilterAction = UIAlertAction(title: "Save Filter without Posting on Facebook", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            self.saveFilterToCoreData(indexPath, caption: text)
        }
        alert.addAction(saveFilterAction)
        
        let cancelAction = UIAlertAction(title: "Select Another Filter", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveFilterToCoreData(indexPath: NSIndexPath, caption: String) {
        let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: filters[indexPath.row])
        let imageData = UIImageJPEGRepresentation(filterImage, 1.0)
        let thumbNailData = UIImageJPEGRepresentation(filterImage, 0.1)
        
        self.thisFeedItem.image = imageData
        self.thisFeedItem.thumbNail = thumbNailData
        self.thisFeedItem.caption = caption
        self.thisFeedItem.filtered = true
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func shareToFacebook(indexPath: NSIndexPath) {
        let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: filters[indexPath.row])
        
        let photos:NSArray = [filterImage]
        var params = FBPhotoParams()
        params.photos = photos as [AnyObject]
        
        FBDialogs.presentShareDialogWithPhotoParams(params, clientState: nil) { (call, result, error) -> Void in
            
            if result != nil {
                println(result)
            } else {
              println(error)
            }
        }
    }
    
    // caching functions
    func cacheImage(imageNumber: Int) {
        let fileName = "\(thisFeedItem.uniqueID)\(imageNumber)"
        
        //unique path in the directory
        let uniquePath = kTemp.stringByAppendingPathComponent(fileName)
        
        if !NSFileManager.defaultManager().fileExistsAtPath(fileName) {
            let data = self.thisFeedItem.thumbNail
            let filter = self.filters[imageNumber]
            let image = filteredImageFromImage(data, filter: filter)
            
            // atomically true write to the backup file and if no errors rewritten
            UIImageJPEGRepresentation(image, 1.0).writeToFile(uniquePath, atomically: true)
        }
    }
    
    func getCacheImage(imageNumber: Int) -> UIImage {
        let fileName = "\(thisFeedItem.uniqueID)\(imageNumber)"
        let uniquePath = kTemp.stringByAppendingPathComponent(fileName)
        var image:UIImage
        
        if NSFileManager.defaultManager().fileExistsAtPath(uniquePath) {
            var returnedImage = UIImage(contentsOfFile: uniquePath)!
            image = UIImage(CGImage: returnedImage.CGImage, scale: 1.0, orientation: UIImageOrientation.Right)!
        } else {
            self.cacheImage(imageNumber)
            var returnedImage = UIImage(contentsOfFile: uniquePath)!
            image = UIImage(CGImage: returnedImage.CGImage, scale: 1.0, orientation: UIImageOrientation.Right)!
        }
        return image
    }
}
