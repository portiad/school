/*
* Copyright (c) 2015 Razeware LLC
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
import CoreData
import CoreLocation
import HealthKit

let DetailSegueName = "RunDetails"

class NewRunViewController: UIViewController {
  var seconds = 0.0
  var distance = 0.0
  
  lazy var locationManager: CLLocationManager = {
    var _locationManager = CLLocationManager()
    _locationManager.delegate = self
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest
    _locationManager.activityType = .Fitness
    
    //Movement thresholds for new events
    _locationManager.distanceFilter = 10.0
    return _locationManager
  }()
  
  lazy var locations = [CLLocation]()
  lazy var timer = NSTimer()
  
  var managedObjectContext: NSManagedObjectContext?

  var run: Run!

  @IBOutlet weak var promptLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var paceLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    startButton.hidden = false
    promptLabel.hidden = false

    timeLabel.hidden = true
    distanceLabel.hidden = true
    paceLabel.hidden = true
    stopButton.hidden = true
    
    locationManager.requestAlwaysAuthorization()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    timer.invalidate()
  }
  
  
  //Functions
  
  func eachSecond(timer: NSTimer) {
    seconds++
    let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
    timeLabel.text = "Time: " + secondsQuantity.description
    let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
    distanceLabel.text = "Distance: " + distanceQuantity.description
    
    let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
    let paceQuanity = HKQuantity(unit: paceUnit, doubleValue: seconds/distance)
    paceLabel.text = "Pace: " + paceQuanity.description
  }
  
  func startLocationUpdates() {
    // Here, the location manager will be lazily instantiated
    locationManager.startUpdatingLocation()
  }
  
  func saveRun() {
    let savedRun = NSEntityDescription.insertNewObjectForEntityForName("Run", inManagedObjectContext: managedObjectContext!) as! Run
    savedRun.distance = distance
    savedRun.duration = seconds
    savedRun.timestamp = NSDate()
    
    var savedLocations = [Location]()
    for location in locations {
      let savedLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedObjectContext!) as! Location
      savedLocation.timestamp = location.timestamp
      savedLocation.latitude = location.coordinate.latitude
      savedLocation.longitude = location.coordinate.longitude
      savedLocations.append(savedLocation)
    }
    
    savedRun.locations = NSOrderedSet(array: savedLocations)
    run = savedRun
    
    do {
      try managedObjectContext!.save()
    } catch {
      print("Unable to save")
    }
  }
  
  // IBActions

  @IBAction func startPressed(sender: AnyObject) {
    startButton.hidden = true
    promptLabel.hidden = true

    timeLabel.hidden = false
    distanceLabel.hidden = false
    paceLabel.hidden = false
    stopButton.hidden = false
    
    seconds = 0.0
    distance = 0.0
    locations.removeAll(keepCapacity: false)
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "eachSecond:", userInfo: nil,repeats: true)
    startLocationUpdates()
  }

  @IBAction func stopPressed(sender: AnyObject) {
    let actionSheet = UIActionSheet(title: "Run Stopped", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Save", "Discard")
    actionSheet.actionSheetStyle = .Default
    actionSheet.showInView(view)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let detailViewController = segue.destinationViewController as? DetailViewController {
      detailViewController.run = run
    }
  }
}

// MARK: UIActionSheetDelegate
extension NewRunViewController: UIActionSheetDelegate {
  func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    //save
    if buttonIndex == 1 {
      saveRun()
      performSegueWithIdentifier(DetailSegueName, sender: nil)
    }
    //discard
    else if buttonIndex == 2 {
      navigationController?.popToRootViewControllerAnimated(true)
    }
  }
}

extension NewRunViewController: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    for location in locations {
      if location.horizontalAccuracy < 20 {
        //update distance
        if self.locations.count > 0 {
          distance += location.distanceFromLocation(self.locations.last!)
        }
        //save location
        self.locations.append(location)
      }
    }
  }
  

}
