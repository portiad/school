//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Portia Dean on 4/1/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) {
            task.task = taskTextField.text.capitalizedString
        } else {
            task.task = taskTextField.text
        }
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) {
            task.completed = true
        } else {
            task.completed = false
        }
        
        task.subtask = subTaskTextField.text
        task.date = dueDatePicker.date
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        
        var results: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}