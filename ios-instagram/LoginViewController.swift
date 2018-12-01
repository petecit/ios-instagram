//
//  ViewController.swift
//  ios-instagram
//
//  Created by peter on 11/30/18.
//  Copyright © 2018 petecit. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        print("\n" + "...trying to login with the username '" + username + "'...\n")
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            
            if let error = error {
                print("\n" + "...User log in failed: \(error.localizedDescription)...\n")
            } else {
                print("\n" + "...login successful...\n")
                
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        print("\n" + "...trying to create a new account with the username '" + newUser.username! + "'...\n")
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print("\n" + error.localizedDescription)
            }
            else {
                print("\n" + "...new account created...")
                
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

