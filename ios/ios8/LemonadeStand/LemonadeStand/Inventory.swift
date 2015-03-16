//
//  InventoryModel.swift
//  LemonadeStand
//
//  Created by Portia Dean on 3/16/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

class Inventory {
    
    var totalDollar: Int
    var totalLemons: Int
    var totalIceCubes: Int
    

    init (totalDollar: Int = 10, totalLemons: Int = 1, totalIceCubes: Int = 1) {
        self.totalDollar = totalDollar
        self.totalLemons = totalLemons
        self.totalIceCubes = totalIceCubes
    }
    
    func consoleLogging(action: String){
        println(action)
    }
    
    /*
    // Getters & setters
    */
    
    func getTotalDollar() -> Int {
        return self.totalDollar
    }
    
    func setTotalDollar(sales: Int = 0) {
        self.totalDollar = self.totalDollar + sales - (self.purchaseLemons * 2) - self.purchaseIceCubes
    }
    
    func getTotalLemons() -> Int {
        return self.totalLemons
    }
    
    func setTotalLemons() {
        self.totalLemons = self.totalLemons + self.purchaseLemons - self.mixLemons
        self.purchaseLemons = 0
        self.mixLemons = 0
    }
    
    func getTotalIceCubes() -> Int{
        return self.totalIceCubes
    }
    
    func setTotalIceCubes() {
        self.totalIceCubes = self.totalIceCubes + self.purchaseIceCubes - self.mixIceCubes
        self.purchaseIceCubes = 0
        self.mixIceCubes = 0
    }
    
    func mixLemons(num: Int) -> Int {
        
        if self.purchaseLemons + self.totalLemons - self.mixLemons - num < 0 {
            return 1
        } else if self.mixLemons + num < 0 {
            return 2
        } else {
            self.mixLemons += num
            return 0
        }
    }
    
    /*
    // Helper Functions
    */
    
    // Preparing 1 - 10 customers for the day with taste preference
    
    func prepareCustomer() -> Array<Float> {
        var totalCustomers = Int(arc4random_uniform(UInt32(9)))
        var customerPreference: [Float] = []
        for totalCustomers; totalCustomers >= 0 ; --totalCustomers{
           var random = Float(arc4random()) /  Float(UInt32.max)
            customerPreference.append(random)
        }
        consoleLogging("\(customerPreference)")
        return customerPreference
    }
}

class Purchases {
    
    var totalDollar: Int
    var totalLemons: Int
    var totalIceCubes: Int
    
    var purchaseLemons = 0
    var purchaseIceCubes = 0
    
    let kCostOfLemon = 2
    let kCostOfIceCube = 1
    
    init (totalDollar: Int, totalLemons: Int, totalIceCubes: Int) {
        self.totalDollar = totalDollar
        self.totalLemons = totalLemons
        self.totalIceCubes = totalIceCubes
    }
    
    /*
    // Getters & setters
    */
    
    func getPurchaseLemons() -> Int {
        return self.purchaseLemons
    }
    
    func purchaseLemons(num: Int) -> Int {
        
        if num * self.kCostOfLemon > self.totalDollar - (self.purchaseLemons * self.kCostOfLemon) - (self.purchaseIceCubes * self.kCostOfIceCube) {
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
    
    func purchaseIceCubes(num: Int) -> Int {
        
        if num * kCostOfIceCube > self.totalDollar - (self.purchaseLemons * self.kCostOfLemon) - (self.purchaseIceCubes * self.kCostOfIceCube) {
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

}

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
    
    func mixLemons(num: Int) -> Int {
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
    
    func mixIceCubes(num: Int) -> Int {
        if self.allIceCubes - self.mixIceCubes - num < 0 {
            return 1 // no ice
        } else if self.mixIceCubes + num < 0 {
            return 2 // negative ice
        } else {
            self.mixIceCubes += num
            return 0
        }
    }
    
    // Prepare lemon to ice cube mix ratio
    
    func mixLemonade() -> Int {
        if self.mixIceCubes == 0 && self.mixLemons == 0 {
            return 2
        } else if self.mixLemons > self.mixIceCubes {
            return 1
        } else if self.mixLemons == self.mixIceCubes {
            return 0
        } else {
            return -1
        }
    }
}