//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by Portia Dean on 7/31/15.
//  Copyright (c) 2015 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class TurnController {
  // Stores both the current turn and past turns.
  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()
  
  // Accepts a ShapeFactory and ShapeViewBuilder.
  init(shapeFactory: ShapeFactory, shapeViewBuilder: ShapeViewBuilder) {
    self.shapeFactory = shapeFactory
    self.shapeViewBuilder = shapeViewBuilder
  }
  
  // Uses this factory and builder to create shapes and views for each new turn and records the current turn.
  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapes = shapeFactory.createShapes()
    let shapeViews = shapeViewBuilder.buildShapeViewsForShapes(shapes)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }
  
  // Records the end of a turn after the player taps a shape, and returns the computed score based on whether the turn was a match or not.
  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompletedWithTappedShape(tappedShape)
    pastTurns.append(currentTurn!)
    
    var scoreIncrement = currentTurn!.matched! ? 1 : -1
    
    return scoreIncrement
  }
  
  private let shapeFactory: ShapeFactory
  private var shapeViewBuilder: ShapeViewBuilder
}