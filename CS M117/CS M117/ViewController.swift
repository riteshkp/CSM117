//
//  ViewController.swift
//  CS M117
//
//  Created by Shrey Kakkar on 5/4/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func action(_ sender: UIButton)
    {
        if emailText.text != "" && passwordText.text != ""
        {
            if segmentControl.selectedSegmentIndex == 0         // login
            {
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                    if user != nil          //user exists, and sign in successful
                    {
                        print("Sucess")
                    }
                    else                    // user not available, going to print error messages
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
                })
            }
            else                                                // sign up user
            {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                    if user != nil          //user exists, and sign up successful
                    {
                        print("Sucess")
                    }
                    else                    // user not available, going to print error messages
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
                })
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

