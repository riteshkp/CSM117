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
            var success = 0
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                if user != nil
                {
                    print("Success")
                    success = 1
                    self.ref = Database.database().reference()
                    let userID = Auth.auth().currentUser?.uid
                    self.ref?.child("GROUPS").child(self.groupIDText.text!).child(userID!).setValue(["ID": userID, "Name": self.nameText.text])
                    self.ref?.child("USERS").child(userID!).setValue(["Name": self.nameText.text!, "Email": self.emailText.text, "Points": 0, "Group" : self.groupIDText.text!])
                }
                else
                {
                    if let myError = error?.localizedDescription        // generic error messages, if available
                    {
                        print (myError)
                        self.createAlertFail(title: "Try Again!", message: myError)

                    }
                    else                // no generic messages error, so print my message
                    {
                        print ("Error")
                        self.createAlertFail(title: "Try Again!", message: "Error")
                    }
                }
                // Get a reference to the database service
                
                if (success == 1)
                {
                    self.createAlert(title: "Success!", message: "")
                }
            })
        }
        else
        {
            createAlertFail(title: "Try Again!", message: "Fill in all areas")
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
    
    
    //popup text function for successful signup
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
           // alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "backtologin", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //popup for failed signup
    func createAlertFail (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
