//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by Portia Dean on 4/15/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData
import MapKit

// UIImagePickerControllerDelegate, UINavigationControllerDelegate required for the camera

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedArray: [AnyObject] = []
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Location Manager Setup
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        let request = NSFetchRequest(entityName: "FeedItem")
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        feedArray = context.executeFetchRequest(request, error: nil)!
        
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func profileTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("profileSegue", sender: nil)
    }
    
    // Setting up camera in app
    @IBAction func snapBarButtonTapped(sender: UIBarButtonItem) {
        //camera is available
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            // UI Controller access movies, camera
            var cameraController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            // Identifier for a certain type of image data
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false
            
            self.presentViewController(cameraController, animated: true, completion: nil)
        }
        //camera not available using photo library
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var photoLibraryController = UIImagePickerController()
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            
            self.presentViewController(photoLibraryController, animated: true, completion: nil)
        }
        else {
            var alertView = UIAlertController(title: "Alert", message: "Your device does not support a camera or photo library", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertView.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
    
    //UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        let thumbNailData = UIImageJPEGRepresentation(image, 0.1)
        
        //initiate a feeditem object
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: managedObjectContext!)
        let feedItem = FeedItem(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        feedItem.image = imageData
        feedItem.caption = "test caption"
        feedItem.thumbNail = thumbNailData
        
        feedItem.latitude = locationManager.location.coordinate.latitude
        feedItem.longitude = locationManager.location.coordinate.longitude
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        
        feedArray.append(feedItem)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.collectionView.reloadData()
        
    }
    
    
    //UICollectionViewDataSource required to add in UICollectionViewDataSouce
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: FeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FeedCell
        
        let thisItem = feedArray[indexPath.row] as! FeedItem
        
        cell.imageView.image = UIImage(data: thisItem.image)
        cell.captionLabel.text = thisItem.caption
        
        return cell
    }
    
    //UICollectionViewDelegate add in filters
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let thisItem = feedArray[indexPath.row] as! FeedItem
        
        var filterVC = FilterViewController()
        filterVC.thisFeedItem = thisItem
        
        self.navigationController?.pushViewController(filterVC, animated: false)
        
    }
    
    //CLLOcation manager delegate
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Locations: \(locations)")
    }
}
