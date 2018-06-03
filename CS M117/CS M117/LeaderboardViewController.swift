//
//  LeaderboardViewController.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 6/2/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var leaderboardTableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count  //makes table view size of how many users there are.
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderboardCell
        cell.configureCell(user: users[indexPath.row])
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUsers()
    }
    
    func fetchUsers() {
        let userRef = dataBaseRef.child("USERS/\(Auth.auth().currentUser!.uid)")    //get user info
        userRef.observe(.value) { (snapshot) in
            
            let user = User(snapshot: snapshot)
            let userGroup = user.group! //get user group
            let groupRef = self.dataBaseRef.child("GROUPS/" + userGroup)
            
            groupRef.observe(.value, with: { (snapshot) in
                
                var results1 = [User]() //for obtaining group
                var results2 = [User]() //for obtaining user b/c group does not contain score
                
                for user in snapshot.children {
                    results1.append(User(snapshot: user as! DataSnapshot))   //Gets all the users in current user group
                }
                
                for user in results1 {
                    let finalUser = self.dataBaseRef.child("USERS/" + user.id!)
                    finalUser.observe(.value, with: { (snapshot) in
                        let userFound = User(snapshot: snapshot)    //Gets user scores
                        results2.append(userFound)
                        self.users = results2
                        DispatchQueue.main.async {
                            self.leaderboardTableView.reloadData()
                        }
                    })
                }
            })
        }
    }
}
