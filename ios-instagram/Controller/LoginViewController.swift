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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*---event handlers---*/
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        print("\n" + "...trying to login with the username '" + username + "'...\n")
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            
            if let error = error {
                print("\n" + "...User log in failed: \(error.localizedDescription)...\n")
                self.displayLoginErrorAlert()
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
                self.displaySignupErrorAlert()
            }
            else {
                print("\n" + "...new account created...")
                self.displaySignupSuccessAlert()
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    /*---display alert methods---*/
    
    // This function is called whenever the sign-in credentials are incorrect. or whenever
    // the sign-up credentials are duplicate, i.e., the user already exists
    func displayLoginErrorAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Login Failed!", message: "Please enter a valid username and password combination.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        // Present the alert and run code to clear the fields in the completing block
        present(alertController, animated: true) {
            self.usernameField.text = ""
            self.passwordField.text = ""
        }
    }
    
    // This function is called whenever the sign-up credentials are duplicate, i.e.,
    // the user already exists in the database
    func displaySignupErrorAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Signup Failed!", message: "That username is already taken. Please choose another one.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        // Present the alert and run code to clear the fields in the completion block
        present(alertController, animated: true) {
            self.usernameField.text = ""
            self.passwordField.text = ""
        }
    }
    
    // The function is called when the user signs-up successfully
    func displaySignupSuccessAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Signup Successful!", message: "New account created.", preferredStyle: .alert)
        // Allow the modal segue to occur when the alert is dismissed
        let dismissAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        // Present the alert to the user
        alertController.addAction(dismissAction)
        present(alertController, animated: true) { }
    }


}

