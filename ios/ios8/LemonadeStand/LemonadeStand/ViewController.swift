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
    let kNoMoneyMessage = "No money"
    
    var inventory: Inventory!
    var purchases: Purchases!
    var mix: Mix!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inventory = Inventory()
        purchases = Purchases(totalDollar: inventory.getTotalDollar(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBAction button pressed functions for updating purchased and mixed values
    
    @IBAction func addLemonsButtonPressed(sender: UIButton) {
        game.purchaseLemons(1)
        updateAllLabels()
    }
    
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        game.purchaseLemons(-1)
        updateAllLabels()
    }
    
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        game.purchaseCubes(1)
        updateAllLabels()
    }
    
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        game.purchaseCubes(-1)
        updateAllLabels()
    }
    
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        game.mixLemons(1)
        updateAllLabels()
    }
    
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        game.mixLemons(1)
        updateAllLabels()
    }
    
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        game.mixIceCubes(1)
        updateAllLabels()
    }
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        game.mixIceCubes(-1)
        updateAllLabels()
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        game.startToday()
        updateAllLabels()
    }
    
    // Starting a new day for sales
    
    func startToday(mixRatio: Int) -> Int {
        
        var totalSales = 0
        var totalCustomers = 0
        var mixRatio = transaction.mixLemonade()
        
        if mixRatio == 2{
            return 1
        }
        
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
        
        consoleLogging("Sales: \(totalSales); Customers: \(totalCustomers); Lemons: \(self.mixLemons); Ice: \(self.mixIceCubes); Ratio: \(mixRatio)")
        
        setTotalDollar(sales: totalSales)
        setTotalLemons()
        setTotalIceCubes()
        
        return 0
    }
    
    func updateAllLabels() {
        mixIceCubesLabel.text = "\(game.getMixIceCubes())"
        mixLemonsLabel.text = "\(game.getMixLemons())"
        iceCubesAddLabel.text = "\(game.getPurchasedIceCubes())"
        lemonsAddLabel.text = "\(game.getPurchaseLemons())"
        dollarTotalLabel.text = "\(game.getTotalDollar())"
        lemonsTotalLabel.text = "\(game.getTotalLemons())"
        iceCubeTotalLabel.text = "\(game.getTotalIceCubes())"
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
