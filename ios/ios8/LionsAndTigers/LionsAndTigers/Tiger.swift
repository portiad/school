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
    
}