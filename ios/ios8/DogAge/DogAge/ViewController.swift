//
//  ViewController.swift
//  DogAge
//
//  Created by Portia Dean on 3/4/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var humanYearsTextField: UITextField!
    
    @IBOutlet weak var dogYearsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertDogYearsButton(sender: UIButton) {
        let conversionDogAge = 7.0
        
        let convertedAge = Double((humanYearsTextField.text as NSString).doubleValue)
        
        dogYearsLabel.text = "You are " + "\(conversionDogAge * conversionDogAge)" + " in dog years."
        dogYearsLabel.hidden = false
        
        humanYearsTextField.resignFirstResponder()
    }

}

