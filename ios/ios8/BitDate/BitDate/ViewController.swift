//
//  ViewController.swift
//  BitDate
//
//  Created by Portia Dean on 6/6/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let cardsVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavigationController") as! UIViewController
    let profileVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileNavigationController") as! UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.whiteColor()
        self.dataSource = self
        
        // which view controller do you want to set to display to user
        self.setViewControllers([cardsVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case cardsVC:
            return profileVC
        case profileVC:
            return nil
        default:
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case cardsVC:
            return nil
        case profileVC:
            return cardsVC
        default:
            return nil
        }
    }
}

