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
    shapeFactory = SquareShapeFactory(minProportion: 0.3, maxProportion: 0.8)
    
    shapeViewBuilder = ShapeViewBuilder(shapeViewFactory: shapeViewFactory)
    shapeViewBuilder.fillColor = UIColor.brownColor()
    shapeViewBuilder.outlineColor = UIColor.orangeColor()
    
    turnController = TurnController(shapeFactory: shapeFactory, shapeViewBuilder: shapeViewBuilder)
    
    // Begin a turn as soon as the GameView loads.
    beginNextTurn()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // Create a pair of square shapes with random side lengths drawn as proportions in the range [0.3, 0.8]. The shapes will also scale to any screen size.
  private func beginNextTurn() {
    // Asks the TurnController to begin a new turn and return a tuple of ShapeView to use for the turn.
    let shapeViews = turnController.beginNewTurn()
    
    // Informs the turn controller that the turn is over when the player taps a ShapeView, and then it increments the score. Notice how TurnController abstracts score calculation away, further simplifying GameViewController.
    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += self.turnController.endTurnWithTappedShape(tappedView.shape)
      self.beginNextTurn()
    }
    
    // Since you removed explicit references to specific shapes, the second shape view can share the same tapHandler closure as the first shape view.
    shapeViews.1.tapHandler = shapeViews.0.tapHandler
    
    // Add the shapes to the GameView so it can lay out the shapes and display them.
    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  private var shapeViewFactory: ShapeViewFactory!
  private var shapeFactory: SquareShapeFactory!
  private var shapeViewBuilder: ShapeViewBuilder!
  private var turnController: TurnController!
}
