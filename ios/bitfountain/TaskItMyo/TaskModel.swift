//
//  TaskModel.swift
//  TaskIt
//
//  Created by Portia Dean on 4/14/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
