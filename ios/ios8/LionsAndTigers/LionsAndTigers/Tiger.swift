//
//  Tiger.swift
//  LionsAndTigers
//
//  Created by Portia Dean on 3/5/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import UIKit


struct Tiger {
    var age = 0
    var name = ""
    var breed = ""
    var image = UIImage(named:"")
    
    func chuff(){
        println("Tiger: Chuff Chuff")
    }
    
    func chuffNumberOfTimes(num: Int){
        for var chuff = 0; chuff < num; chuff++ {
            self.chuff()
        }
    }
    
    func chuffNuberofTimes(num:Int, loud:Bool) {
        for var chuff = 0; chuff < num; chuff++ {
            if loud {
                self.chuff()
            }
            else {
                println("Tiger: purr purr")
            }
        }
    }
    
    func ageInTigerYearsFromAge(regularAge:Int) ->Int {
        return regularAge * 3
    }
    
    func randomFact() ->String {
        let randomNum = Int(arc4random_uniform(UInt32(3)))
        
        var randomFact:String
        
        if randomNum == 0 {
            randomFact = "Tiger is the biggest species in the cat family"
        }
        else if randomNum == 1 {
            randomFact = "Tigers can reach a length of 3.3 meters"
        }
        else {
            randomFact = "A group of tigers is know as an ambush or a streak"
        }
        
        return randomFact
    }
    
}