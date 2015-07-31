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
    
    // 1
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
    
    // Ask the GameView what size is available for each shape based on the current screen size.
    let availSize = gameView.sizeAvailableForShapes()
    
    // Create a SquareShapeView for each shape, and size the shape by multiplying the shape’s sideLength proportion by the appropriate availSize dimension of the current screen.
    let shapeView1: ShapeView = SquareShapeView(frame: CGRect(x: 0, y: 0, width: availSize.width * shape1.sideLength, height: availSize.height * shape1.sideLength))
    shapeView1.shape = shape1
    let shapeView2: ShapeView = SquareShapeView(frame: CGRect(x: 0, y: 0, width: availSize.width * shape2.sideLength, height: availSize.height * shape2.sideLength))
    shapeView2.shape = shape2
    
    // Store the shapes in a tuple for easier manipulation.
    let shapeViews = (shapeView1, shapeView2)
    
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
}
