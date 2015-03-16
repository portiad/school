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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let game = Inventory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startDayButtonPressed(sender: UIButton) {
        var mixRatio = 0
        var totalSales = 0
        var totalCustomers = 0
        var lose = false
        
        if mixLemons > mixIceCubes {
            mixRatio = 1
        }
        else if mixLemons == mixIceCubes {
            mixRatio = 0
        }
        else {
            mixRatio = -1
        }
        
        let customers = prepareCustomer()
        
        /* Determines if you made sales that day
        //        0 to 0.4 – favors acidic lemonade
        //        0.4 to 0.6 – favors equal parts lemonade
        //        0.6 to 1 – favors diluted lemonade
        
        //        Greater than 1 (Acidic Lemonade)
        //        Equal to 1 (Equal Portioned Lemonade)
        //        Less than 1 (Diluted Lemonade)
        */
        
        for customer in customers {
            if customer <= 0.4 && customer >= 0.0 && mixRatio == 1 {
                totalCustomers += 1
                totalSales += 1
            }
            else if customer <= 0.6 && customer >= 0.4 && mixRatio == 0 {
                totalCustomers += 1
                totalSales += 1
            }
            else if  customer <= 1.0 && customer >= 0.6 && mixRatio == -1{
                totalCustomers += 1
                totalSales += 1
            }
        }
        
        totalDollar += totalSales
        totalLemons = totalLemons + purchaseLemons - mixLemons
        totalIceCubes = totalIceCubes + purchaseIceCubes - mixIceCubes
        
        showAlertWithText(header: "Summary of Today", message: "You had a total of \(totalCustomers) today. For a total of sales of \(totalSales)")
        
        if totalLemons + totalIceCubes + totalDollar <= 0 {
            lose = true
        }
        
        newDay(reset: lose)
        
    }
    
    // IBAction button pressed functions for updating purchased and mixed values
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        mixIceCubs(-1)
    }
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        mixIceCubs(1)
    }
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        mixLemons(-1)
    }
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        mixLemons(1)
    }
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        iceCubeUpdate(-1)
    }
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        lemonUpdate(-1)
    }
    @IBAction func addLemonsButtonPressed(sender: UIButton) {
        lemonUpdate(1)
        updateLabelText(lemonsAddLabel, update: purchaseLemons)
    }
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        iceCubeUpdate(1)
    }
    
    // Prepare a random number of customers and their taste preference between 0 and 1
    
    func prepareCustomer() -> Array<Double> {
        var totalCustomers = Int(arc4random_uniform(UInt32(9)))
        var customerPreference: [Double] = []
        for totalCustomers; totalCustomers >= 0 ; --totalCustomers{
            customerPreference.append(1/Double(arc4random_uniform(UInt32(10))))
        }
        
        return customerPreference
    }
    
    func updateLabelText(label: UILabel, update:Int) {
        label.text = "\(update)"
    }
    
    // Updates the values for a new day
    
    func newDay(reset:Bool = false) {
        
        if reset {
            totalDollar = 10
            totalLemons = 1
            totalIceCubes = 1
        }

        purchaseLemons = 0
        purchaseIceCubes = 0
        mixIceCubes = 0
        mixLemons = 0
        
        updateLabelText(mixIceCubesLabel, update: 0)
        updateLabelText(mixLemonsLabel, update: 0)
        updateLabelText(iceCubesAddLabel, update: 0)
        updateLabelText(lemonsAddLabel, update: 0)
        updateLabelText(lemonsTotalLabel, update: totalLemons)
        updateLabelText(dollarTotalLabel, update: totalDollar)
        updateLabelText(iceCubeTotalLabel, update: totalIceCubes)
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
