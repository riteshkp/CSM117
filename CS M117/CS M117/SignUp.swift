//
//  SignUp.swift
//  CS M117
//
//  Created by Shrey Kakkar on 5/9/18.
//  Copyright © 2018 Shrey Kakkar. All rights reserved.
//

import UIKit

class SignUp: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    
    @IBAction func signUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backtologin", sender: self)
    }
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var groupIDText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var newgroupButton: UIButton!
    
    @IBAction func signupnew(_ sender: Any) {
    }
    
    
    @IBOutlet weak var newgroup: UIButton!
    
    
    
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
