//
//  RWTItemCell.swift
//  ForgetMeNotSwift
//
//  Created by Portia Dean on 8/8/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class RWTItemCell: UITableViewCell {
    
    var item: RWTItem? {
        didSet {
            if var item = item {
                self.textLabel?.text = self.item?.name
                updateDetailLabel()
            }
        }
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
    
    func updateDetailLabel() {
        self.detailTextLabel?.text = self.item?.nameForProximity(self.item!.lastSeenBeacon!.proximity)
    }
}