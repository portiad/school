//
//  DetailViewController.swift
//  FoodTracker
//
//  Created by Portia Dean on 5/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var usdaItem: USDAItem?

    @IBOutlet weak var textView: UITextView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "usdaItemDidComplete:", name: kUSDAItemCompleted, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // best pratice to remove observer once you have completed
    deinit {
        println("usdaItemDidComplete in DetailViewController")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eatItBarButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    func usdaItemDidComplete(notification: NSNotification) {
        usdaItem = notification.object as? USDAItem
    }
}
