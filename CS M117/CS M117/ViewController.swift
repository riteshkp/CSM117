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
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func signup(_ sender: Any) {
        self.performSegue(withIdentifier: "signup", sender: self)
    }
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func action(_ sender: UIButton)
    {
        if emailText.text != "" && passwordText.text != ""
        {
            // This is for Log in. Doesnt Change
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                    if user != nil          //user exists, and sign in successful
                    {
                        self.performSegue(withIdentifier: "signedIn", sender: self)    // the withIdentifier is segue too because we names the switch from one screen to the other as segue
                        print("Log in Success")
                    }
                    else                    // user not available, going to print error messages
                    {
                        if let myError = error?.localizedDescription        // generic error messages, if available
                        {
                            print (myError)
                            self.createAlertFail(title: "Try again!", message: myError)

                        }
                        else                // no generic messages error, so print my message
                        {
                            self.performSegue(withIdentifier: "segue", sender: self)
                            print ("Sign up Error")
                        }
                    }
                })
        }
        else //if blank show popup
        {
            self.createAlertFail(title: "Try again!", message: "Please enter Email and Password")
        }
    }
    
    func createAlertFail (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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

