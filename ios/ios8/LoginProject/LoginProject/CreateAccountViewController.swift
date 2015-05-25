//
//  CreateAccountViewController.swift
//  LoginProject
//
//  Created by Portia Dean on 5/24/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var chooseUsernameTextField: UITextField!
    @IBOutlet weak var choosePasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.view.subviews
    }
    
    
    @IBAction func createAccountButtonPressed(sender: UIButton) {
        
        for view in self.view.subviews {
            if view.isKindOfClass(UITextField) {
                var text:UITextField = view as! UITextField
        
                if text.text.isEmpty {
                    let alert = UIAlertController(title: "Check", message: "Check", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            }
        }
    
        //if choosePasswordTextField.text == confirmPasswordTextField.text
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
