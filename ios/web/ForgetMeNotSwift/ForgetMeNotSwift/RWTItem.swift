//
//  RWTItem.swift
//  ForgetMeNotSwift
//
//  Created by Portia Dean on 8/7/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import CoreLocation

let kRWTItemNameKey: String = "name"
let kRWTItemUUIDKey: String = "uuid"
let kRWTItemMajorValueKey: String = "major"
let kRWTItemMinorValueKey: String = "minor"

class RWTItem: NSObject {
    
    var name: String
    var uuid: NSUUID
    var majorValue: NSNumber
    var minorValue: NSNumber
    
    init(name: String, uuid: NSUUID, major: NSNumber?, minor: NSNumber?) {
        self.name = name
        self.uuid = uuid
        self.majorValue = major != nil ? major! : 0
        self.minorValue = minor != nil ? minor! : 0
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(kRWTItemNameKey) as! String
        self.uuid = aDecoder.decodeObjectForKey(kRWTItemUUIDKey) as! NSUUID
        self.majorValue = aDecoder.decodeObjectForKey(kRWTItemMajorValueKey) as! NSNumber
        self.minorValue = aDecoder.decodeObjectForKey(kRWTItemMinorValueKey) as! NSNumber
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey:kRWTItemNameKey)
        aCoder.encodeObject(self.uuid, forKey:kRWTItemUUIDKey)
        aCoder.encodeObject(self.majorValue, forKey:kRWTItemMajorValueKey)
        aCoder.encodeObject(self.minorValue, forKey:kRWTItemMinorValueKey)
    }
    
    func isEqualToCLBeacon(beacon: CLBeacon) -> Bool {
        let matchUUID = beacon.proximityUUID == self.uuid
        let beaconMajor = beacon.major == self.majorValue
        let beaconMinor = beacon.minor == self.minorValue
        
        if matchUUID && beaconMajor && beaconMinor {
            return true
        } else {
            return false
        }
    }
}
