//
//  LoginViewController.swift
//  BitDate
//
//  Created by Portia Dean on 6/8/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFBLogin(sender: UIButton) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "user_about_me", "user_birthday"], block: { (user, error) in
            if user == nil {
                println("Uh oh. The user cancelled the Facebook Login.")
                //Add UIAlertController before pushing to app store
                return
            } else if user!.isNew {
                var graphRequest = FBSDKGraphRequest(graphPath: "/me?fields=picture,first_name,birthday,gender", parameters: nil)
                graphRequest.startWithCompletionHandler({ (connection, result, error) in
                    var r = result as! NSDictionary
                    user!["firstName"] = r["first_name"]
                    user!["gender"] = r["gender"]
                    user!["picture"] = ((r["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"]
                    
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    user!["birthday"] = dateFormatter.dateFromString(r["birthday"] as! String)
                    
                    user!.saveInBackgroundWithBlock( {
                        success, error in
                        println(success)
                        println(error)
                    })
                })
                
                println("User signed up and logged into Facebook")
            } else {
                println("User logged in through Facebook")
            }
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavigationController") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
            
        })
    }
}
