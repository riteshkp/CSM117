//
//  LeaderboardCell.swift
//  CS M117
//
//  Created by Ritesh Pendekanti on 6/2/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
class LeaderboardCell: UITableViewCell {
    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    func configureCell(user: User){
        self.UserLabel.text = user.name!
        self.ScoreLabel.text = String(user.points!)
    }
}
