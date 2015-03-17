//
//  InventoryModel.swift
//  LemonadeStand
//
//  Created by Portia Dean on 3/16/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

/*********************************************************************************
// Inventory class to manage the total amount of dollars, lemons and ice cubes
**********************************************************************************/

class Inventory {
    
    var totalDollars: Int
    var totalLemons: Int
    var totalIceCubes: Int
    

    init (totalDollars: Int = 10, totalLemons: Int = 1, totalIceCubes: Int = 1) {
        self.totalDollars = totalDollars
        self.totalLemons = totalLemons
        self.totalIceCubes = totalIceCubes
    }

    
    // Getters & setters
    
    func getTotalDollars() -> Int {
        return self.totalDollars
    }
    
    func setTotalDollars(sales: Int, costs: Int) {
        self.totalDollars = self.totalDollars + sales - costs
    }
    
    func getTotalLemons() -> Int {
        return self.totalLemons
    }
    
    func setTotalLemons(totalLemons: Int) {
        self.totalLemons = totalLemons
    }
    
    func getTotalIceCubes() -> Int{
        return self.totalIceCubes
    }
    
    func setTotalIceCubes(totalIceCubes: Int) {
        self.totalIceCubes = totalIceCubes
    }
}

/*********************************************************************************
// Purchases class to manage the proposed changes to dollars, lemons and ice cubes
**********************************************************************************/

class Purchases {
    
    var totalDollars: Int
    var totalLemons: Int
    var totalIceCubes: Int
    
    var purchaseLemons = 0
    var purchaseIceCubes = 0
    
    let kCostOfLemon = 2
    let kCostOfIceCube = 1
    
    init (totalDollar: Int, totalLemons: Int, totalIceCubes: Int) {
        self.totalDollars = totalDollar
        self.totalLemons = totalLemons
        self.totalIceCubes = totalIceCubes
    }
    
    
    // Getters & setters
    
    func getCurrentDollarTotal() -> Int {
        return self.totalDollars - (self.purchaseLemons * self.kCostOfLemon) - (self.purchaseIceCubes * self.kCostOfIceCube)
    }
    
    func getPurchaseLemons() -> Int {
        return self.purchaseLemons
    }
    
    func setPurchaseLemons(num: Int) -> Int {
        
        if num * self.kCostOfLemon > getCurrentDollarTotal() {
            return 1 // no money
        } else if self.purchaseLemons + num < 0 {
            return 2 // negative lemons
        } else {
            self.purchaseLemons += num
            return 0
        }
    }
    
    func getPurchaseIceCubes() -> Int {
        return self.purchaseIceCubes
    }
    
    func setPurchaseIceCubes(num: Int) -> Int {
        
        if num * kCostOfIceCube > getCurrentDollarTotal() {
            return 1 // no money
        } else if self.purchaseIceCubes + num < 0 {
            return 2 // negative ice
        } else {
            self.purchaseIceCubes += num
            return 0
        }
    }
    
    func getAllIceCubes() -> Int {
        return self.purchaseIceCubes + self.totalIceCubes
    }
    
    func getAllLemons() -> Int {
        return self.purchaseLemons + self.totalLemons
    }
    
    func getTotalCost() -> Int {
        return (self.purchaseLemons * self.kCostOfLemon) + (self.purchaseIceCubes * self.kCostOfIceCube)
    }

}

/**************************************************************************************
// Mix class to manage the proposed mixed amounts and final change to lemon & ice cube
**************************************************************************************/

class Mix {
    var allLemons: Int
    var allIceCubes: Int
    
    var mixLemons = 0
    var mixIceCubes = 0
    
    init (allLemons: Int, allIceCubes: Int) {
        
        self.allLemons = allLemons
        self.allIceCubes = allIceCubes
    }
    
    func getMixLemons() -> Int {
        return self.mixLemons
    }
    
    func setMixLemons(num: Int) -> Int {
        if self.allLemons - self.mixLemons - num < 0 {
            return 1 // no lemons
        } else if self.mixLemons + num < 0 {
            return 2 // negative lemons
        } else {
            self.mixLemons += num
            return 0
        }
    }
    
    func getMixIceCubes() -> Int {
        return self.mixIceCubes
    }
    
    func setMixIceCubes(num: Int) -> Int {
        if self.allIceCubes - self.mixIceCubes - num < 0 {
            return 1 // no ice
        } else if self.mixIceCubes + num < 0 {
            return 2 // negative ice
        } else {
            self.mixIceCubes += num
            return 0
        }
    }
    
    func getCurrentLemons() -> Int {
        return self.allLemons - self.mixLemons
    }
    
    func setCurrentLemons(allLemons: Int) {
        self.allLemons = allLemons
    }
    
    func getCurrentIceCubes() -> Int {
        return self.allIceCubes - self.mixIceCubes
    }
    
    func setCurrentIceCubes(allIceCubes: Int) {
        self.allIceCubes = allIceCubes
    }
}