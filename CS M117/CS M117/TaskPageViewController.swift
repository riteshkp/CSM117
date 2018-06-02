//
//  TaskPageViewController.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 5/29/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class TaskPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        
    }

    @IBAction func plus(_ sender: Any) {
        self.performSegue(withIdentifier: "addTask", sender: self)
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        print("Did it work???")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "segue2", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count  //makes table view size of how many tasks there are.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskNameLabel.text = tasks[indexPath.row].taskID   //sets label in cell to task ID.
        if tasks[indexPath.row].isCompleted{//Sets checkbox accordingly
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED-1"), for: UIControlState.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
        }
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let vc = segue.destination as! ViewController
//        let vc = segue.destination as! AddTaskViewController
//        vc.delegate = self
//    }
    
    func addTask(name: String, points: Int, deadline: Date) {
        tasks.append(Task(taskID: name, taskPoints: points, deadline: deadline))
        tableView.reloadData()
    }
    
    func changeButton(checked: Bool, index: Int?) {
        tasks[index!].isCompleted = checked
        tableView.reloadData()
    }
    
}

