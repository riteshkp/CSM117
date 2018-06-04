//
//  Users.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 6/2/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
struct User{
    var name: String!
    var ref: DatabaseReference!
    var key: String?
    var group: String?
    var points: Int?
    var id: String?
    
    init(snapshot: DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
        name = (snapshot.value! as! NSDictionary)["Name"] as! String
        group = (snapshot.value! as! NSDictionary)["Group"] as? String
        points = (snapshot.value! as! NSDictionary)["Points"] as? Int
        id = (snapshot.value! as! NSDictionary)["ID"] as? String
    }
}
