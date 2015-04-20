//
//  MapViewController.swift
//  ExchangeAGram
//
//  Created by Portia Dean on 4/20/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Paris
        var location = CLLocationCoordinate2D(latitude: 48.868639224587, longitude: 2.37119161036255)
        //amount of area span for the map
        let span = MKCoordinateSpanMake(0.05, 0.05)
        //region map to display
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
