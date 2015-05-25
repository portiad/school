//
//  LoginViewController.swift
//  LoginProject
//
//  Created by Portia Dean on 5/24/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("loginToMainSegue", sender: self)
    }
    
    
    @IBAction func createAccountButtonPressed(sender: UIButton) {
        println("i'm here")
        
        self.performSegueWithIdentifier("loginToCreateAccountSegue", sender: self)
    }

}
