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
        if tasks![indexP!].isCompleted {
            delegate?.changeButton(checked: false, index: indexP!)
        } else {
            delegate?.changeButton(checked: true, index: indexP!)
        }
    }
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    var delegate: ChangeButton?
    var indexP: Int?
    var tasks: [Task]?
}
