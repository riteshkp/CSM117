//
//  DatabaseTask.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 6/4/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
struct DatabaseTask {
    var Group: String!
    var deadline: String!
    var points: Int!
    var user: String!
    var ref: DatabaseReference!
    var key: String?

    init(snapshot: DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
        Group = (snapshot.value! as! NSDictionary)["Group"] as! String
        deadline = (snapshot.value! as! NSDictionary)["deadline"] as! String
        points = (snapshot.value! as! NSDictionary)["points"] as? Int
        user = (snapshot.value! as! NSDictionary)["user"] as? String
    }
}
