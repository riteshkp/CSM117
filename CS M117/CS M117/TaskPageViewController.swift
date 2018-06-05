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
    var loadedTasks: [DatabaseTask] = [] //For tasks loaded from database
    
    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    override func viewDidLoad() {
        fetchTasks()
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
        return loadedTasks.count  //makes table view size of how many tasks there are.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.configureCell(tasks: loadedTasks[indexPath.row])
        /*if tasks[indexPath.row].isCompleted{//Sets checkbox accordingly
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED-1"), for: UIControlState.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
        }*/
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.loadedTasks = loadedTasks
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let userRef = dataBaseRef.child("USERS/\(Auth.auth().currentUser!.uid)")    //get user info
            userRef.observe(.value) { (snapshot) in
                
                let user = User(snapshot: snapshot)
                let userPoints = user.points! //get user points
                let addpoints: Int? = self.loadedTasks[indexPath.row].points
                let newpoints = userPoints + addpoints!; //add points from this task
                
               // print(tasks.(indexPath).points)
              //  print(indexPath.row)
              //  print( self.tasks[indexPath.row] )
                
              //  userRef = Database.database().reference()
                //user.ref.child("Points").setValue(newpoints)
                //child("Points").setValue(newpoints)
                user.ref.updateChildValues(["Points":newpoints]) //changes user points in database
                
                
                //remove in database
                //print(self.loadedTasks[indexPath.row].ref)
                //let ref = self.dataBaseRef.child("Tasks").child(self.loadedTasks[indexPath.row].ref).removeValue()
                
                self.loadedTasks[indexPath.row].ref.removeValue() //remove task from database
                self.loadedTasks.remove(at: indexPath.row) //remove task from tableview
                
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
              //  tableView.reloadData()

            }
            
           
            //remove task from database
            
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! ViewController
//        let vc = segue.destination as! AddTaskViewController
//        vc.delegate = self
//    }
    
    func addTask(name: String, points: Int, deadline: Date) {
        tasks.append(Task(taskID: name, taskPoints: points, deadline: deadline))
        tableView.reloadData()
    }
    
//    func changeButton(checked: Bool, index: Int?) {
//        tasks[index!].isCompleted = checked
//        tableView.reloadData()
//    }
    
    func changeButton(checked: Bool, index: Int?) {
        
    }
    
    
    
    func fetchTasks() {
        let userRef = dataBaseRef.child("USERS/\(Auth.auth().currentUser!.uid)")    //get user info
        userRef.observe(.value) { (snapshot) in
            
            let user = User(snapshot: snapshot)
            let userGroup = user.group! //get group user belongs to
            let taskRef = self.dataBaseRef.child("Tasks")
            
            taskRef.observe(.value, with: { (snapshot) in
                
                var results = [DatabaseTask]()
                
                for tasks in snapshot.children {
                    results.append(DatabaseTask(snapshot: tasks as! DataSnapshot))   //Gets all tasks
                }
                
                for tasks in results {
                    if tasks.Group == userGroup {
                        self.loadedTasks.append(tasks)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }

}


