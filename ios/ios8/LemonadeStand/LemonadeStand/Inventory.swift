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
    
    /*
    // Getters & setters
    */
    
    func getPurchaseLemons() -> Int {
        return self.purchaseLemons
    }
    
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
    
    func getPurchasedIceCubes() -> Int {
        return self.purchaseIceCubes
    }
    
    
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
    
    func getTotalDollar() -> Int {
        return self.totalDollar
    }
    
    func setTotalDollar(sales: Int = 0) {
        self.totalDollar = sales - (self.purchaseLemons * 2) - self.purchaseIceCubes
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
    
    func setTotalIceCubes(reset: Bool = false) {
        if !reset {
            self.totalIceCubes = self.totalIceCubes + self.purchaseIceCubes - self.mixIceCubes
            self.purchaseIceCubes = 0
            self.mixIceCubes = 0
        } else {
            self.totalIceCubes = 0
        }
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
    
    /*
    // Helper Functions
    */
    
    // Preparing 1 - 10 customers for the day with taste preference
    
    func prepareCustomer() -> Array<Double> {
        var totalCustomers = Int(arc4random_uniform(UInt32(9)))
        var customerPreference: [Double] = []
        for totalCustomers; totalCustomers >= 0 ; --totalCustomers{
            customerPreference.append(1/Double(arc4random_uniform(UInt32(10))))
        }
        
        return customerPreference
    }
    
    func checkResetGame() -> Bool {
        
        if self.totalDollar + self.totalIceCubes + self.totalLemons <= 0 {
            self.totalDollar = 10
            self.totalIceCubes = 1
            self.totalLemons = 1
            return true
        } else {
            return false
        }
    }
    
    // Starting a new day for sales
    
    func startDaysSales() -> Bool {
    
        var mixRatio = 0
        var totalSales = 0
        var totalCustomers = 0
        
        // Prepare lemon to ice cube mix ratio
        
        if self.mixLemons > self.mixIceCubes {
            mixRatio = 1
        }
        else if self.mixLemons == self.mixIceCubes {
            mixRatio = 0
        }
        else {
            mixRatio = -1
        }
        
        let customers = prepareCustomer()
        
        // Iterate over your customers array and determine who will buy lemonade based on mix ratio

        for customer in customers {
            if customer <= 0.4 && customer >= 0.0 && mixRatio == 1 {
            totalCustomers += 1
            totalSales += 1
            } else if customer <= 0.6 && customer >= 0.4 && mixRatio == 0 {
                totalCustomers += 1
                totalSales += 1
            } else if  customer <= 1.0 && customer >= 0.6 && mixRatio == -1{
                totalCustomers += 1
                totalSales += 1
            }
        }
        
        setTotalDollar(sales: totalSales)
        setTotalLemons()
        setTotalIceCubes()
        
        // Check if you ran out of money, ice cubes and lemons
        
        if checkResetGame() {
            return false
        }
        
        return true
    }
}