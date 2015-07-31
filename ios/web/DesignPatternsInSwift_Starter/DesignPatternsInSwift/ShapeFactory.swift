//
//  ShapeFactory.swift
//  DesignPatternsInSwift
//
//  Created by Portia Dean on 7/31/15.
//  Copyright (c) 2015 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

// Again, you’ve declared the ShapeFactory as a protocol to build in maximum flexibility, just like you did for ShapeViewFactory.
protocol ShapeFactory {
  func createShapes() -> (Shape, Shape)
}

class SquareShapeFactory: ShapeFactory {
  // You want your shape factory to produce shapes that have dimensions in unit terms, for instance, in a range like [0, 1] — so you store this range.
  var minProportion: CGFloat
  var maxProportion: CGFloat
  
  init(minProportion: CGFloat, maxProportion: CGFloat) {
    self.maxProportion = maxProportion
    self.minProportion = minProportion
  }
  
  func createShapes() -> (Shape, Shape) {
    // Create the first square shape with random dimensions.
    let shape1 = SquareShape()
    shape1.sideLength = Utils.randomBetweenLower(minProportion, andUpper: maxProportion)
    
    // Create the second square shape with random dimensions.
    let shape2 = SquareShape()
    shape2.sideLength = Utils.randomBetweenLower(minProportion, andUpper: maxProportion)
    
    // Return the pair of square shapes as a tuple. 
    return (shape1, shape2)
  }
}