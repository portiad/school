//
//  RWTItemsViewController.swift
//  ForgetMeNotSwift
//
//  Created by Portia Dean on 8/7/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import CoreLocation

let kRWTStoredItemsKey: NSString = "storedItems"

class RWTItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var itemsTableView: UITableView!
    var items: NSMutableArray = []
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.itemsTableView.registerClass(RWTItemCell.self, forCellReuseIdentifier: "Item")
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self
        
        locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.loadItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddSegue" {
            var navController: UINavigationController = segue.destinationViewController as! UINavigationController
            
            if let addItemViewController: RWTAddItemViewController = navController.topViewController as? RWTAddItemViewController {
                addItemViewController.itemAddedCompletion = {
                    newItem in
                    self.itemsTableView.beginUpdates()
                    self.items.addObject(newItem)
                    var newIndexPath: NSIndexPath = NSIndexPath(forRow: self.items.count - 1, inSection: 0)
                    self.itemsTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.itemsTableView.endUpdates()
                    self.startMonitoring(newItem)
                    self.persistItems()
                }
            }
        }
    }
    
    func loadItems() {
        var storedItems: NSArray? = NSUserDefaults.standardUserDefaults().arrayForKey(kRWTStoredItemsKey as String)
        self.items = NSMutableArray()
        if storedItems != nil {
            for itemData in storedItems! {
                var item: RWTItem = NSKeyedUnarchiver.unarchiveObjectWithData(itemData as! NSData) as! RWTItem
                self.items.addObject(item)
                self.startMonitoring(item)
            }
        }
    }
    
    func persistItems() {
        var itemsDataArray = NSMutableArray()
        for item in self.items {
            var itemData: NSData = NSKeyedArchiver.archivedDataWithRootObject(item)
            itemsDataArray.addObject(itemData)
        }
        NSUserDefaults.standardUserDefaults().setObject(itemsDataArray, forKey: kRWTStoredItemsKey as String)
        
    }
    
    // MARK - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("Item") as! RWTItemCell
        var cell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath) as! RWTItemCell
        var item: RWTItem = self.items[indexPath.row] as! RWTItem
        cell.item = item
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let itemToRemove: RWTItem = self.items.objectAtIndex(indexPath.row) as! RWTItem
            self.stopMonitoring(itemToRemove)
            tableView.beginUpdates()
            self.items.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
            self.persistItems()
        }
    }
    
    //MARK - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var item: RWTItem = self.items.objectAtIndex(indexPath.row) as! RWTItem
        var detailMessage: NSString = NSString(format: "UUID: %@\nMajor: %d\nMinor: %d", item.uuid.UUIDString, item.majorValue, item.minorValue)
        var detailAlert: UIAlertView = UIAlertView(title: "Details", message: detailMessage as String, delegate: nil, cancelButtonTitle: "Close")
        detailAlert.show()
    }
    
    //MARK - CLLocationDelegate
    
    func beaconRegionWithItem(item: RWTItem) -> CLBeaconRegion {
        let beaconRegion = CLBeaconRegion(proximityUUID: item.uuid, major: CLBeaconMajorValue(Int(item.majorValue)), minor: CLBeaconMajorValue(Int(item.minorValue)), identifier: item.name as String)
        
        return beaconRegion
    }
    
    func startMonitoring(item: RWTItem) {
        let beaconRegion = beaconRegionWithItem(item)
        self.locationManager.startMonitoringForRegion(beaconRegion)
        self.locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func stopMonitoring(item: RWTItem) {
        let beaconRegion = beaconRegionWithItem(item)
        self.locationManager.stopMonitoringForRegion(beaconRegion)
        self.locationManager.stopRangingBeaconsInRegion(beaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        NSLog("Failed monitoring region: %@", error)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Location manager failed: %@", error)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        for beacon in beacons {
            for item in self.items {
                if (item as! RWTItem).isEqualToCLBeacon(beacon as! CLBeacon) {
                    (item as! RWTItem).lastSeenBeacon = beacon as? CLBeacon
                }
            }
        }
    }
}