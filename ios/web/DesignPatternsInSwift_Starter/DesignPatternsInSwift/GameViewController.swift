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
    shapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    
    // Begin a turn as soon as the GameView loads.
    beginNextTurn()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // Create a pair of square shapes with random side lengths drawn as proportions in the range [0.3, 0.8]. The shapes will also scale to any screen size.
  private func beginNextTurn() {
    let shape1 = SquareShape()
    shape1.sideLength = Utils.randomBetweenLower(0.3, andUpper: 0.8)
    let shape2 = SquareShape()
    shape2.sideLength = Utils.randomBetweenLower(0.3, andUpper: 0.8)
    
    // Use this new factory to create your shape views.
    let shapeViews = shapeViewFactory.makeShapesViewsForShape((shape1, shape2))
    
    // Set the tap handler on each shape view to adjust the score based on whether the player tapped the larger view or not.
    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += shape1.sideLength >= shape2.sideLength ? 1 : -1
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = {
      tappedView in
      self.gameView.score += shape2.sideLength >= shape1.sideLength ? 1 : -1
      self.beginNextTurn()
    }
    
    // Add the shapes to the GameView so it can lay out the shapes and display them.
    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  
  // Store your new shape view factory as an instance property
  private var shapeViewFactory: ShapeViewFactory!
}
