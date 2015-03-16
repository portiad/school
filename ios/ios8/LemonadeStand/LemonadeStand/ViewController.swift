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
    

    
    func updateLabelText(label: UILabel, update:Int) {
        label.text = "\(update)"
    }
    
    // Updates the values for a new day
    

    
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
