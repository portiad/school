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
    
    var purchaseLemons = 0
    var purchaseIceCubes = 0
    
    var mixLemons = 0
    var mixIceCubes = 0
    
    
    init (totalDollar: Int = 10, totalLemons: Int = 1, totalIceCubes: Int = 1) {
        self.totalDollar = totalDollar
        self.totalLemons = totalLemons
        self.totalIceCubes = totalIceCubes
    }
    
    // Getters & setters for lemons
    
    func purchaseLemons(num: Int) -> Int {
        
        if num * 2 > self.totalDollar - (self.purchaseLemons * 2) - self.purchaseIceCubes {
            return 1
        } else if self.purchaseLemons + num < 0 {
            return 2
        }else {
            self.purchaseLemons += num
            return 0
        }
    }
    
    func getPurchaseLemons() -> Int {
        return self.purchaseLemons
    }
    
    // Getters and setter for ice cubes
    
    func purchaseCubes(num: Int) -> Int {
        
        if num > self.totalDollar - (self.purchaseLemons * 2) - self.purchaseIceCubes {
            return 1
        } else if self.purchaseIceCubes + num < 0 {
            return 2
        }
        else {
            self.purchaseIceCubes += num
            return 0
        }
    }
    
    func getPurchasedIceCubes() -> Int {
        return self.purchaseIceCubes
    }
    
    // Mixing up ratio for lemons and icecubes
    
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
    
    func getMixLemons() -> Int {
        return self.mixLemons
    }
    
    func mixIceCubes(num: Int) -> Int {
        if self.purchaseIceCubes + self.totalIceCubes - self.mixIceCubes - num < 0 {
            return 1
        } else if self.mixIceCubes + num < 0 {
            return 2
        } else {
            self.mixIceCubes += num
            return 0
        }
    }
    
    func getMixIceCubes() -> Int {
        return self.mixIceCubes
    }
    
}