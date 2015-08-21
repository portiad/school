//
//  Turn.swift
//  DesignPatternsInSwift
//
//  Created by Portia Dean on 7/31/15.
//  Copyright (c) 2015 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class Turn {
  // Store the shapes that the player saw during the turn, and also whether the turn was a match or not.
  let shapes: [Shape]
  var matched: Bool?
  
  init(shapes: [Shape]) {
    self.shapes = shapes
  }
  
  // Records the completion of a turn after a player taps a shape.
  func turnCompletedWithTappedShape(tappedShape: Shape) {
    var maxArea = shapes.reduce(0) {$0 > $1.area ? $0 : $1.area}
    matched = tappedShape.area >= maxArea
  }
}