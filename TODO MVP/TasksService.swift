//
//  TasksService.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 30/07/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//


/**
 Performs the following Task related functions:
 - Fetch tasks
 - Add task
 - Edit task
 - Delete task
 - Search for task
 
 These tasks are done either on a web API or Cache data store or Core Data
 */

import Foundation

class TaskService {
    
    func getTasks(completion: @escaping ([Task]) -> Void) {
        
        var tasks: [Task] = []
        tasks.append(Task(title: "Make TODO MVP app"))
        tasks.append(Task(title: "Do you say you love me?"))
        tasks.append(Task(title: "Lately I'm falling down!"))
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            completion(tasks)
        }
    }
    
}
