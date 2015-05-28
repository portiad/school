//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Portia Dean on 5/25/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewTodoTableView: UITableView!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    let kVersionNumber = "1.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        
        self.completeNewTodoTableView.delegate = self
        self.completeNewTodoTableView.dataSource = self
        self.completeNewTodoTableView.scrollEnabled = false
        
        self.title = "Settings"
        
        self.versionLabel.text = kVersionNumber
        
        //change title of bar button item
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonPressed:"))
        
        self.navigationItem.leftBarButtonItem = doneButton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneBarButtonPressed(barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.capitalizeTableView {
            var capitalizeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as! UITableViewCell
            
            if indexPath.row == 0 {
                capitalizeCell.textLabel?.text = "No do not capitalize"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                } else {
                    //show a check mark if
                   capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            } else {
                capitalizeCell.textLabel?.text = "Capitalize"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return capitalizeCell
        } else {
            var todoCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as! UITableViewCell
            
            if indexPath.row == 0 {
                todoCell.textLabel?.text = "Do not complete task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey){
                    todoCell.accessoryType = UITableViewCellAccessoryType.None
                } else {
                    todoCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            } else {
                todoCell.textLabel?.text = "Complete task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) {
                    todoCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    
                } else {
                    todoCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return todoCell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitalizeTableView {
            return "Capitalize new task?"
        } else {
            return "Complete new task?"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.capitalizeTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        } else {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewTodoKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewTodoKey)
            }
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
}
