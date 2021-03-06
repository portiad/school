//
//  MapViewController.swift
//  ExchangeAGram
//
//  Created by Portia Dean on 4/20/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //sending a request to get back all the feed items back from coredata
        let request = NSFetchRequest(entityName: "FeedItem")
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
        var error:NSError?
        //& is a pointer
        let itemArray = context.executeFetchRequest(request, error: &error)
        println(error)
        
        println(mapView.frame)
        
        if itemArray!.count > 0 {
            for item in itemArray! {
                let location = CLLocationCoordinate2D(latitude: Double(item.latitude), longitude: Double(item.longitude))
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegionMake(location, span)
                //don't need to have this here since only the last region will be centered on the map
                mapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = item.caption
                mapView.addAnnotation(annotation)
            }
        }
        
        
        //Paris
//        var location = CLLocationCoordinate2D(latitude: 48.868639224587, longitude: 2.37119161036255)
//        //amount of area span for the map
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        //region map to display
//        let region = MKCoordinateRegionMake(location, span)
//        mapView.setRegion(region, animated: true)
//        
//        //setting up marker
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Canal Saint-Martin"
//        annotation.subtitle = "Paris"
//        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
