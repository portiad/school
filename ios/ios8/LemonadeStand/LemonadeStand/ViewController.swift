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
    
    // Classes
    var inventory: Inventory!
    var purchases: Purchases!
    var mix: Mix!
    
    // Messages
    let kmNoMoneyMessage = "You do not have enough money"
    let kmZeroLemons = "You have no more lemons"
    let kmZeroIceCubes = "You have no more ice cubes"
    let kmNegativeLemons = "Lemons can not be less than 0"
    let kmNegativeIceCubes = "Ice cubes can not be less than 0"
    
    var weatherEffectOnCustomers: Int

    
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
        setAllLabels()
    }
    
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(-1)
        setAllLabels()
    }
    
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(1)
        setAllLabels()
    }
    
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(-1)
        setAllLabels()
    }
    
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(1)
        setAllLabels()
    }
    
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(-1)
        setAllLabels()
    }
    
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(1)
        setAllLabels()
    }
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(-1)
        setAllLabels()
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        startToday()
        setAllLabels()
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
    
    func setTodaysWeather() {
        var random = Int(arc4random_uniform(UInt32(2)))
        
        switch random {
        case 0: // cloudy
            weatherEffectOnCustomers = -3
        case 1: // sunny
            weatherEffectOnCustomers = 4
        default: // fair
            weatherEffectOnCustomers = 0
        }
    }
    
    // Preparing 1 - 10 customers for the day with taste preference
    
    func prepareCustomer() -> Array<Float> {
        var totalCustomers = Int(arc4random_uniform(UInt32(9))) + weatherEffectOnCustomers
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

    func resetDay() {
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
        
        if inventory.totalDollars + inventory.totalIceCubes + inventory.totalLemons <= 0{
            resetGame()
        }
    }
    
    func resetGame() {
        inventory = Inventory()
        
    }
    
    func setAllLabels() {
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
