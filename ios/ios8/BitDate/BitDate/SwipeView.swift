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
    
    enum Direction {
        case None
        case Left
        case Right
    }
    
    weak var delegate: SwipeViewDelegate?
    
    let overlay: UIImageView = UIImageView()

    // Makes it so CardViewController manages the CardView
    var innerView: UIView? {
        didSet {
            if let v = innerView {
                insertSubview(v, belowSubview: overlay)
                v.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
            }
            
        }
    }
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
        
        // add the ability to drag views
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        
        self.overlay.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        addSubview(self.overlay)
        
        
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
            if abs(distance.x) < frame.width/4 {
                resetViewPositionandTransformations()
            } else {
                swipe(distance.x > 0 ? .Right : .Left)
            }
            
        default:
            println("default triggered for gesture reconginizer")
            break
        }
    }
    
    func swipe(swipeDirection: Direction ) {
        if swipeDirection == .None {
            return
        } else {
            var parentWidth = superview!.frame.size.width
            
            if swipeDirection == .Left {
                parentWidth *= -1
            }
            
            UIView.animateWithDuration(0.2, animations: {
                self.center.x = self.frame.origin.x + parentWidth
            }, completion: {
                success in
                if let swipeDelegate = self.delegate {
                    swipeDirection == .Right ? swipeDelegate.swipedRight() : swipeDelegate.swipedLeft()
                }
            })
        }
    }
    
    private func resetViewPositionandTransformations() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0.0)
        })
    }
}

protocol SwipeViewDelegate: class {
    func swipedLeft()
    func swipedRight()
}

