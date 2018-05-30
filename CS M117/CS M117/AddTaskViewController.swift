//
//  AddTaskViewController.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 5/29/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit

protocol AddTask {
    func addTask(name: String, points: Int, deadline: Date)
}

class AddTaskViewController: UIViewController {
    @IBOutlet weak var taskNameOutlet: UITextField!
    @IBOutlet weak var taskPointsOutlet: UITextField!
    @IBOutlet weak var deadlineOutlet: UITextField!
    
    let deadlinePicker = UIDatePicker()
    
    @IBAction func addAction(_ sender: Any) {
        let taskPoints: Int? = Int(taskPointsOutlet.text!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let deadlineDate = dateFormatter.date(from: deadlineOutlet.text!)
        if (taskNameOutlet.text != "") && (taskPoints != nil) && (deadlineOutlet.text != "") {
            delegate?.addTask(name: taskNameOutlet.text!, points: taskPoints!, deadline: deadlineDate!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems(([doneButton]), animated: false)
        deadlineOutlet.inputAccessoryView = toolbar
        deadlineOutlet.inputView = deadlinePicker
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        deadlineOutlet.text = dateFormatter.string(from: deadlinePicker.date)
        self.view.endEditing(true)
    }
}
