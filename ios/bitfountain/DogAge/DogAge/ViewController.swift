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
        let conversion2DogAge = 10.5
        let conversion3DogAge = 4.0
        var convertedDogAge:Double
        
        let Age = Double((humanYearsTextField.text as NSString).doubleValue)
        if Age <= 2 {
            convertedDogAge = Age * conversion2DogAge
        }
        else {
            convertedDogAge = (conversion2DogAge * 2) + (Age - 2) * conversion3DogAge
        }
        
        dogYearsLabel.text = "You are " + "\(convertedDogAge)" + " in dog years."
        dogYearsLabel.hidden = false
        
        humanYearsTextField.resignFirstResponder()
    }

}

