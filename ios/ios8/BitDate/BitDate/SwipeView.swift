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
        
        self.backgroundColor = UIColor.redColor()
        addSubview(card)
        
        // add the ability to drag views
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        
        card.frame = CGRect(x: 0.0, y: 0.00, width: frame.width, height: frame.height)
    }
    
    func dragged(gestureRecongnizer: UIPanGestureRecognizer) {
        let distance = gestureRecongnizer.translationInView(self)
        println("distance - x:\(distance.x) y:\(distance.y)")
        
        // determine state of users interaction with the view
        switch gestureRecongnizer.state {
        case UIGestureRecognizerState.Began :
            originalPoint = self.center
        case UIGestureRecognizerState.Changed:
            let rotationPercentage = min(distance.x/(self.superview!.frame.width/2), 1)
            let rotationAngle = (CGFloat(2*M_PI/16)*rotationPercentage)
            transform = CGAffineTransformMakeRotation(rotationAngle)
            
            self.center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
        case UIGestureRecognizerState.Ended:
            resetViewPositionandTransformations()
        default:
            println("default triggered for gesture reconginizer")
            break
        }
    }
    
    private func resetViewPositionandTransformations() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0.0)
        })
    }
}

