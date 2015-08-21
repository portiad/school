//
//  ViewController.swift
//  ShoeSizeConverter
//
//  Created by Portia Dean on 3/4/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mensShoeSizeTextField: UITextField!
    @IBOutlet weak var mensConvertedShoeSizeLabel: UILabel!
    
    @IBOutlet weak var womensShoeSizeTextField: UITextField!
    @IBOutlet weak var womensConvertedShoeSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertButtonPressed(sender: UIButton) {
        let conversionConstant = 30
        
        let sizeFromTextField = mensShoeSizeTextField.text.toInt()!
        mensConvertedShoeSizeLabel.text = "\(sizeFromTextField + conversionConstant)" + " in European Shoe Size"
        
        mensShoeSizeTextField.text = ""
        mensShoeSizeTextField.resignFirstResponder()
        
        mensConvertedShoeSizeLabel.hidden = false
        
    }

    @IBAction func convertWomenButtonPressed(sender: UIButton) {
        let conversionConstant = 30.5
        
        let sizeFromTextField = Double((womensShoeSizeTextField.text as NSString).doubleValue)
        womensConvertedShoeSizeLabel.text = "\(sizeFromTextField + conversionConstant)" + " in European Shoe Size"
        
        womensShoeSizeTextField.text = ""
        womensShoeSizeTextField.resignFirstResponder()
        
        womensConvertedShoeSizeLabel.hidden = false
        
    }
}

