//
//  ViewController.swift
//  TaskIt
//
//  Created by Portia Dean on 3/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var taskArry:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task1: Dictionary<String, String> = ["task": "Study French", "subtask": "Verbs in past and present", "date": "01/10/2014"]
        let task2: Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01/10/2014"]
        let task3: Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01/14/2014"]
        taskArry = [task1, task2, task3]
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArry.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        var taskDict:Dictionary = taskArry[indexPath.row]
        
        cell.taskLabel.text = taskDict["task"]
        cell.descriptionLabel.text = taskDict["subtask"]
        cell.dateLabel.text = taskDict["date"]
        
        return cell
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

