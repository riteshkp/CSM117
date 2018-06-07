//
//  TaskCell.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 5/29/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit

protocol ChangeButton {
    func changeButton(checked: Bool, index: Int?)
}

class TaskCell: UITableViewCell {
    @IBAction func checkBoxAction(_ sender: Any) {
        if loadedTasks![indexP!].user == "" {
            delegate?.changeButton(checked: false, index: indexP!)
        } else {
            delegate?.changeButton(checked: true, index: indexP!)
        }
    }
    
    func configureCell(tasks: DatabaseTask){
        self.taskNameLabel.text = tasks.key
        self.pointsLabel.text = String(tasks.points)
        self.deadlineLabel.text = tasks.deadline
        
        let currentDateTime = Date()
        
        if tasks.deadline < dateToString(givenDate: currentDateTime){
            self.taskNameLabel.textColor = UIColor.red
            self.pointsLabel.textColor = UIColor.red
            self.deadlineLabel.textColor = UIColor.red
        }
        else {
            self.taskNameLabel.textColor = UIColor.black
            self.pointsLabel.textColor = UIColor.black
            self.deadlineLabel.textColor = UIColor.black
        }
    }
    
    func dateToString(givenDate: Date) -> String
    {
        let date = givenDate // Get Todays Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate: String = dateFormatter.string(from: date as! Date)
        return stringDate
    }
    
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    var delegate: ChangeButton?
    var indexP: Int?
    var loadedTasks: [DatabaseTask]?
}
