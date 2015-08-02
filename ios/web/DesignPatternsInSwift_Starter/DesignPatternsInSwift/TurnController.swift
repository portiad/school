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
  
  // Accepts a passed strategy and stores it on the TurnController instance
  init(turnStrategy: TurnStrategy) {
    self.turnStrategy = turnStrategy
  }
  
  func beginNewTurn() -> (ShapeView, ShapeView) {
    // Uses the strategy to generate the ShapeView objects so the player can begin a new turn.
    let shapeViews = turnStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns)
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
  private let turnStrategy: TurnStrategy
}