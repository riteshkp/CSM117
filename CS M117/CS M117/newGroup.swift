//
//  newGroup.swift
//  CS M117
//
//  Created by Shrey Kakkar on 5/9/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class newGroup: UIViewController {
    var ref:DatabaseReference?
    
    @IBOutlet weak var backToSignUp: UIButton!
    
    @IBAction func backtosignup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backsignup", sender: self)
    }
    
    @IBOutlet weak var groupIDText: UITextField!
    
    @IBAction func creategroup(_ sender: UIButton) {
        
    if groupIDText.text != ""
    {
        ref = Database.database().reference()
    ref?.child("list").childByAutoId().setValue(groupIDText.text)
        }
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
