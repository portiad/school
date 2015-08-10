//
//  RWTItemCell.swift
//  ForgetMeNotSwift
//
//  Created by Portia Dean on 8/8/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import CoreLocation

class RWTItemCell: UITableViewCell {
    
    var item: RWTItem? {
        // Called before setting item variable
        willSet {
            if (self.item != nil) {
                self.item?.removeObserver(self, forKeyPath: "lastSeenBeacon")
            }
        }
        // Called after setting the item variable
        didSet {
            if let item = item {
                self.textLabel!.text = self.item!.name as String
                item.addObserver(self, forKeyPath: "lastSeenBeacon", options: NSKeyValueObservingOptions.New, context: nil)
            }
        }
    }
    
    // You should also remove the observer when the cell is deallocated
    deinit {
        self.removeObserver(self, forKeyPath: "lastSeenBeacon")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.item = nil
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if object.isEqual(self.item) && keyPath == "lastSeenBeacon" {
            var proximity = self.nameForProximity(self.item!.lastSeenBeacon!.proximity)
            self.detailTextLabel?.text = NSString(format: "Location: %@", proximity) as String
        }
    }
    
    func nameForProximity(proximity: CLProximity) -> String {
        switch proximity {
        case CLProximity.Unknown:
            return "Unknown"
        case CLProximity.Near:
            return "Near"
        case CLProximity.Immediate:
            return "Immediate"
        case CLProximity.Far:
            return " Far"
        default:
            return "Default"
        }
    }
}
