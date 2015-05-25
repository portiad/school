//
//  MainViewController.swift
//  LoginProject
//
//  Created by Portia Dean on 5/24/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(kUsernameKey) as? String
        passwordLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(kPasswordKey) as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
