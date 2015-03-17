//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Portia Dean on 3/15/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dollarTotalLabel: UILabel!
    @IBOutlet weak var lemonsTotalLabel: UILabel!
    @IBOutlet weak var iceCubeTotalLabel: UILabel!
    @IBOutlet weak var lemonsAddLabel: UILabel!
    @IBOutlet weak var iceCubesAddLabel: UILabel!
    @IBOutlet weak var mixLemonsLabel: UILabel!
    @IBOutlet weak var mixIceCubesLabel: UILabel!
    
    // Messages
    let kNoMoneyMessage = "Not enough money"
    
    var inventory: Inventory!
    var purchases: Purchases!
    var mix: Mix!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inventory = Inventory()
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // IBAction functions
    */
    
    @IBAction func addLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(1)
        updateAllLabels()
    }
    
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(-1)
        updateAllLabels()
    }
    
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(1)
        updateAllLabels()
    }
    
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(-1)
        updateAllLabels()
    }
    
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(1)
        updateAllLabels()
    }
    
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(-1)
        updateAllLabels()
    }
    
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(1)
        updateAllLabels()
    }
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(-1)
        updateAllLabels()
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        startToday()
        updateAllLabels()
    }
    
    // Preparing 1 - 10 customers for the day with taste preference
    
    func prepareCustomer() -> Array<Float> {
        var totalCustomers = Int(arc4random_uniform(UInt32(9)))
        var customers: [Float] = []
        for totalCustomers; totalCustomers >= 0 ; --totalCustomers{
            var random = Float(arc4random()) /  Float(UInt32.max)
            customers.append(random)
        }
        return customers
    }
    
    // Prepare lemon to ice cube mix ratio
    
    func getLemonadeRatio() -> Int {
        var iceCubes = mix.getMixIceCubes()
        var lemons = mix.getMixLemons()
        
        if lemons == 0 && iceCubes == 0 {
            return 2
        } else if lemons > iceCubes {
            return 1
        } else if lemons == iceCubes {
            return 0
        } else {
            return -1
        }
    }
    
    // Starting a new day for sales
    
    func startToday() {
        
        var totalSales = 0
        var totalCustomers = 0
        
        let mixRatio = getLemonadeRatio()
        let customers = prepareCustomer()
        
        // Iterate over your customers array and determine who will buy lemonade based on mix ratio
        
        for customer in customers {
            if customer >= 0.0 && customer <= 0.4 && mixRatio == 1 {
                totalCustomers += 1
                totalSales += 1
            } else if customer >= 0.4 && customer <= 0.6 && mixRatio == 0 {
                totalCustomers += 1
                totalSales += 1
            } else if customer >= 0.6 && customer <= 1.0 && mixRatio == -1{
                totalCustomers += 1
                totalSales += 1
            }
        }
        
        inventory.setTotalDollars(totalSales, costs: purchases.getTotalCost())
        inventory.setTotalLemons(mix.getCurrentLemons())
        inventory.setTotalIceCubes(mix.getCurrentIceCubes())
        
        resetDay()
    }
    
    func resetDay() {
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
        
    }
    
    func resetGame() {
        inventory = Inventory()
        
    }
    
    func updateAllLabels() {
        mixIceCubesLabel.text = "\(mix.getMixIceCubes())"
        mixLemonsLabel.text = "\(mix.getMixLemons())"
        iceCubesAddLabel.text = "\(purchases.getPurchaseIceCubes())"
        lemonsAddLabel.text = "\(purchases.getPurchaseLemons())"
        dollarTotalLabel.text = "\(inventory.getTotalDollars())"
        lemonsTotalLabel.text = "\(inventory.getTotalLemons())"
        iceCubeTotalLabel.text = "\(inventory.getTotalIceCubes())"
    }
    

    
    func showAlertWithText(var header: String = "Warning", var message: String = "Warning", errorCode: Int = 0) {
        
        if errorCode == -99 {
            header = "No money"
            message = "Purchase fewer items"
        }
        else if errorCode == -98 {
            message = "Cannot buy negative amounts"
        }
        else if errorCode == -97 {
            header = "Unknown Product"
            message = "Please contact customer support"
        }
        
        
        
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
