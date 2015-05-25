//
//  CreateAccountViewController.swift
//  LoginProject
//
//  Created by Portia Dean on 5/24/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit


// be able to call accountCreated() function from other uiviews
protocol createAccountViewControllerDelegate {
    func accountCreated()
}

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var chooseUsernameTextField: UITextField!
    @IBOutlet weak var choosePasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var delegate: createAccountViewControllerDelegate?
    
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
        var error: Bool = false
        for view in self.view.subviews {
            if view.isKindOfClass(UITextField) {
                var text:UITextField = view as! UITextField
        
                if text.text.isEmpty {
                    error = true
                }
            }
        }
        
        if error {
            
        } else if choosePasswordTextField.text == confirmPasswordTextField.text {
            
            // Save information about the user in the session and more sessions
            NSUserDefaults.standardUserDefaults().setObject(self.chooseUsernameTextField.text, forKey: kUsernameKey)
            NSUserDefaults.standardUserDefaults().setObject(self.choosePasswordTextField.text, forKey: kPasswordKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            delegate?.accountCreated()
        }
        
    
        //if choosePasswordTextField.text == confirmPasswordTextField.text
        
        
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
