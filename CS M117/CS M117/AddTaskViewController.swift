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
  
    @IBAction func back(_ sender: Any) {
        self.performSegue(withIdentifier: "backTask", sender: self)
    }
    
    @IBOutlet weak var taskNameOutlet: UITextField!
    @IBOutlet weak var taskPointsOutlet: UITextField!
    @IBOutlet weak var deadlineOutlet: UITextField!
    
    let deadlinePicker = UIDatePicker()
    
    @IBAction func addAction(_ sender: Any)
    {
        
        // My non- working data
        guard let userID = Auth.auth().currentUser?.uid else {return}
        ref = Database.database().reference()

        let taskPoints: Int? = Int(taskPointsOutlet.text!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let deadlineDate = dateFormatter.date(from: deadlineOutlet.text!)
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        
        if taskNameOutlet.text?.rangeOfCharacter(from: characterset.inverted) != nil {
            self.createAlertFail(title: "Try again!", message: "only alphanumeric characters are allowed for task name")
        }
        else if (taskNameOutlet.text != "") && (taskPoints != nil) && (deadlineOutlet.text != "") {
            delegate?.addTask(name: taskNameOutlet.text!, points: taskPoints!, deadline: deadlineDate!)
            let stringDate = dateToString(givenDate: deadlineDate!)
            ref?.child("USERS").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                var groupName = value?["Group"] as? String ?? ""
                self.addToDatabase(name: self.taskNameOutlet.text!, points: taskPoints!, deadline: stringDate, group: groupName)

            }) { (error) in
                print(error.localizedDescription)
            }
          //ej
            self.createAlert(title: "Success!", message: "")

        }
        else if(!(deadlineOutlet.text != ""))
        {
            self.createAlertFail(title: "Try again!", message: "fill in all fields")
        }
        else if(!(taskPoints != nil))
        {
            self.createAlertFail(title: "Try again!", message: "please enter only numbers for task points")
        }
        else
        {
            self.createAlertFail(title: "Try again!", message: "fill in all fields")
        }
        navigationController?.popViewController(animated: true)
    }
    
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }

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
        inputs = ["user": "" , "deadline": deadline, "points": points, "Group": group]
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
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            // alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "addedTask", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func createAlertFail (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
   
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        deadlineOutlet.text = dateFormatter.string(from: deadlinePicker.date)
        self.view.endEditing(true)
    }
}
