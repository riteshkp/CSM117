//
//  SignUp.swift
//  CS M117
//
//  Created by Shrey Kakkar on 5/9/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class SignUp: UIViewController {
    var ref:DatabaseReference?
    @IBOutlet weak var signUp: UIButton!
    

    @IBAction func signUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backtologin", sender: self)
    }
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var groupIDText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var newgroupButton: UIButton!
    @IBAction func signupnew(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" && groupIDText.text != "" && nameText.text != ""
        {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                if user != nil
                {
                    print("Sucess")
                }
                else
                {
                    if let myError = error?.localizedDescription        // generic error messages, if available
                    {
                        print (myError)
                    }
                    else                // no generic messages error, so print my message
                    {
                        print ("Error")
                    }
                }
                // Get a reference to the database service
//                var database = firebase.database();
                self.ref = Database.database().reference()
                let userID = Auth.auth().currentUser?.uid
                self.ref?.child(self.groupIDText.text!).child(userID!).setValue(["ID": userID, "Name": self.nameText.text])
                self.ref?.child("Users").child(userID!).setValue(["Name": self.nameText.text!, "Email": self.emailText.text, "Points": 0, "Group" : self.groupIDText.text!])
            })
            
           
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
