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
                    var fbResult = result as! NSDictionary
                    user!["firstName"] = fbResult["first_name"]
                    user!["gender"] = fbResult["gender"]
                    
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    user!["birthday"] = dateFormatter.dateFromString(fbResult["birthday"] as! String)
                    
                    let pictureURL = ((fbResult["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"] as! String
                    let url = NSURL(string: pictureURL)
                    let request = NSURLRequest(URL: url!)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                        let imageFile: AnyObject = PFFile(name: "avatar.jpg", data: data) as AnyObject
                        user!["picture"] = imageFile
                        user!.saveInBackgroundWithBlock(nil)
                    })

//
//                    user!.saveInBackgroundWithBlock( {
//                        success, error in
//                        println(success)
//                        println(error)
//                    })
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
