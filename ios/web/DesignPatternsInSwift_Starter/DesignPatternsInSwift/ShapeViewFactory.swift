//
//  ShapeViewFactory.swift
//  DesignPatternsInSwift
//
//  Created by Portia Dean on 7/31/15.
//  Copyright (c) 2015 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

// Define ShapeViewFactory as a Swift protocol. There’s no reason for it to be a class or struct since it only describes an interface and has no functionality itself.
protocol ShapeViewFactory {
  // Each factory should have a size that defines the bounding box of the shapes it creates. This is essential to layout code using the factory-produced views.
  var size: CGSize {get set}
  
  // Define the method that produces shape views. This is the “meat” of the factory. It takes a tuple of two Shape objects and returns a tuple of two ShapeView objects. This essentially manufactures views from its raw materials — the models.
  func makeShapesViewsForShape(shapes: (Shape, Shape)) -> (ShapeView, ShapeView)
}

class SquareShapeViewFactory: ShapeViewFactory {
  var size: CGSize
  
  // Initialize the factory to use a consistent maximum size.
  init(size: CGSize) {
    self.size = size
  }
  
  func makeShapesViewsForShape(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    // Construct the first shape view from the first passed shape
    let squareShape1 = shapes.0 as! SquareShape
    let shapeView1 = SquareShapeView(frame: CGRect(x: 0, y: 0, width: squareShape1.sideLength * size.width, height: squareShape1.sideLength * size.height))
    shapeView1.shape = squareShape1
    
    // Construct the second shape view from the second passed shape.
    let squareShape2 = shapes.1 as! SquareShape
    let shapeView2 = SquareShapeView(frame: CGRect(x: 0, y: 0, width: squareShape2.sideLength * size.width, height: squareShape2.sideLength * size.height))
    shapeView2.shape = squareShape2
    
    // Return a tuple containing the two created shape views.
    return (shapeView1, shapeView2)
  }
}
