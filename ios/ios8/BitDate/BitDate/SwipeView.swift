//
//  SwipeView.swift
//  BitDate
//
//  Created by Portia Dean on 6/6/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
    private let card: CardView = CardView()
    
    private var originalPoint: CGPoint?
    
    
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
        self.backgroundColor = UIColor.clearColor()
        addSubview(card)
        
        // add the ability to drag views
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        
        originalPoint = center
        
        card.setTranslatesAutoresizingMaskIntoConstraints(false)
        setConstraints()
    }
    
    func dragged(gestureRecongnizer: UIPanGestureRecognizer) {
        let distance = gestureRecongnizer.translationInView(self)
        println("distance - x:\(distance.x) y:\(distance.y)")
        
        center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
    }
    
    private func setConstraints() {
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: card, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: card, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: card, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
    }
}

