//
//  AddTaskViewController.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 5/29/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
protocol AddTask {
    func addTask(name: String, points: Int, deadline: Date)
}

class AddTaskViewController: UIViewController {
    var ref:DatabaseReference?
  
    
    @IBOutlet weak var taskNameOutlet: UITextField!
    @IBOutlet weak var taskPointsOutlet: UITextField!
    @IBOutlet weak var deadlineOutlet: UITextField!
    
    let deadlinePicker = UIDatePicker()
    
    @IBAction func addAction(_ sender: Any) {
        
        // My non- working data
        let userID = Auth.auth().currentUser?.email
        ref = Database.database().reference()
        // My top posts by number of stars
        let myTopPostsQuery = (ref?.child("Users"))?.queryOrdered(byChild: "Shrey")
        // My top posts by number of stars
        print (myTopPostsQuery)
        
        // my non working data ends here
        
        
        
        let taskPoints: Int? = Int(taskPointsOutlet.text!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let deadlineDate = dateFormatter.date(from: deadlineOutlet.text!)
        if (taskNameOutlet.text != "") && (taskPoints != nil) && (deadlineOutlet.text != "") {
            delegate?.addTask(name: taskNameOutlet.text!, points: taskPoints!, deadline: deadlineDate!)
            let stringDate = dateToString(givenDate: deadlineDate!)
            let groupID = ""
            addToDatabase(name: taskNameOutlet.text!, points: taskPoints!, deadline: stringDate, group: groupID)
    

        }
        navigationController?.popViewController(animated: true)
    }
//    var ref:DatabaseReference?

    func dateToString(givenDate: Date) -> String
    {
        let date = givenDate // Get Todays Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate: String = dateFormatter.string(from: date as! Date)
        return stringDate
    }
    func addToDatabase(name: String, points: Int, deadline: String, group: String)
    {
        var inputs = [String:Any]()
        inputs = ["user": "" , "deadline": deadline, "points": points]
        ref = Database.database().reference()
        ref?.child("Tasks").child(name).setValue(inputs)
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
