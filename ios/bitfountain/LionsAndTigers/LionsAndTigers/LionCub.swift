//
//  LionCub.swift
//  LionsAndTigers
//
//  Created by Portia Dean on 3/11/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

class LionCub:Lion {
    
    func rubLionCubsBelly() {
        println("Lion Cub: Snuggle and be happy")
    }
    
    override func roar() {
        super.roar()
        
        println("Lion Cub: Growl, growl")
    }
    
    override func randomFact() -> String {
        var randomFact:String
        
        if isAlphaMale {
            randomFact = "Cubs are you usually hidden for 6 weeks"
        }
        else {
            randomFact = "Cubs begin eatting meat at about the age of 6 weeks"
        }
        
        return randomFact
    }
}