//
//  Lion.swift
//  LionsAndTigers
//
//  Created by Portia Dean on 3/11/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import UIKit

class Lion {
    var age = 0
    var isAlphaMale = false
    var image = UIImage(named: "")
    var name = ""
    var subspecies = ""
    
    func roar() {
        println("Lion: Roar, roar")
    }
    
    func changeToAlphaMale() {
        self.isAlphaMale = true
    }
    
    func randomFact() -> String {
        var randomFact:String
        
        if self.isAlphaMale {
            randomFact = "Males with darker manes attract more females"
        }
        else {
            randomFact = "Female do not tolerate outside females"
        }
        
        return randomFact
    }
}