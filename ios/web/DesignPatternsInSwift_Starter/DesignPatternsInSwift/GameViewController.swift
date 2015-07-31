//
//  GameViewController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    // Initialize and store a SquareShapeViewFactory.
    shapeViewFactory = CircleShapeViewFactory(size: gameView.sizeAvailableForShapes())
    shapeFactory = CircleShapeFactory(minProportion: 0.3, maxProportion: 0.8)
    
    // Begin a turn as soon as the GameView loads.
    beginNextTurn()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // Create a pair of square shapes with random side lengths drawn as proportions in the range [0.3, 0.8]. The shapes will also scale to any screen size.
  private func beginNextTurn() {
    
    // Use your new shape factory to create a tuple of shapes.
    let shapes = shapeFactory.createShapes()
    
    // Use this new factory to create your shape views.
    let shapeViews = shapeViewFactory.makeShapesViewsForShape(shapes)
    
    // Set the tap handler on each shape view to adjust the score based on whether the player tapped the larger view or not.
    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += shapes.0.area >= shapes.1.area ? 1 : -1
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = {
      tappedView in
      self.gameView.score += shapes.1.area >= shapes.0.area ? 1 : -1
      self.beginNextTurn()
    }
    
    // Add the shapes to the GameView so it can lay out the shapes and display them.
    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  
  // Store your new shape view factory as an instance property
  private var shapeViewFactory: ShapeViewFactory!
  
  private var shapeFactory: CircleShapeFactory!
}
