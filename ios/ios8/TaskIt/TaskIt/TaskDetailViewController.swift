//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Portia Dean on 3/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subTask
        self.dueDatePicker.date = detailTaskModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
