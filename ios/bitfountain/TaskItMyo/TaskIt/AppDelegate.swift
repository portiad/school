//
//  AppDelegate.swift
//  TaskIt
//
//  Created by Portia Dean on 3/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import CoreData

let kShouldCapitalizeTaskKey = "shouldCapitalizeTask"
let kShouldCompleteNewTodoKey = "completeNewTodo"
let kLoadedOnceKey = "loadOnce"

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // This checks for the first time to make sure that this runs only the first time a person runs the application (ex. tutorials)
        if NSUserDefaults.standardUserDefaults().boolForKey(kLoadedOnceKey) == false {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: kLoadedOnceKey)
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewTodoKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        TLMHub.sharedHub()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"didReceivePoseChange:", name:TLMMyoDidReceivePoseChangedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"didReceiveOrientationEvent:", name:TLMMyoDidReceiveOrientationEventNotification, object: nil)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func didReceivePoseChange(notification: NSNotification) {
        let pose = notification.userInfo![kTLMKeyPose] as! TLMPose!
        switch(pose.type.rawValue) {
        case 0:
            println("REST")
            break
        case 1:
            println("FIST")
            break
        case 2:
            println("WAVE IN")
            break
        case 3:
            println("WAVE OUT")
            break
        case 4:
            println("FINGERS SPREAD")
            break
        case 5:
            println("DOUBLE TAP")
            break
        case 6:
            println("UNKNOWN")
            break
        default:
            println("INVALID MOVE")
            break
        }
    }
    
    func didReceiveOrientationEvent(notification: NSNotification) {
        let orientation = notification.userInfo![kTLMKeyOrientationEvent] as! TLMOrientationEvent!
    }
    
    func holdUnlockForMyo(myo: TLMMyo) {
        myo.unlockWithType(TLMUnlockType.Hold)
    }
    
    func endHoldUnlockForMyo(myo: TLMMyo, immediately: Bool) {
        if(immediately) {
            myo.lock()
        } else {
            myo.unlockWithType(TLMUnlockType.Hold)
        }
    }
}

