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
    var game: Inventory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = Inventory()
        
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
