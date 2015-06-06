//
//  CardView.swift
//  BitDate
//
//  Created by Portia Dean on 6/6/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    
    private let imageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        initialize()
    }
    
    private func initialize() {
        
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.backgroundColor = UIColor.redColor()
        addSubview(imageView)
        
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(nameLabel)
        
        backgroundColor = UIColor.whiteColor()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
}