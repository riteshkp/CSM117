//
//  Task.swift
//  CS M117
//
//  Created by Shrey Kakkar on 5/28/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Task {
    let taskID: String
    let taskPoints: Int
    var userID: String
    let deadline: Date
    var isCompleted: Bool
    
    init()
    {
        self.taskID = ""
        self.taskPoints = 0
        self.userID = ""
        self.deadline = Date()
        self.isCompleted = false
        
    }
    init(taskID: String, taskPoints: Int, deadline: Date)
    {
        self.taskID = taskID
        self.taskPoints = taskPoints
        self.userID = ""
        self.deadline = deadline
        self.isCompleted = false
    }
    
    func taskfinished(userID: String)
    {
        if(self.userID == "")
        {
            self.userID = userID
//            ...
        }
    }
    
}
