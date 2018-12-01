//
//  HomeFeedViewController.swift
//  ios-instagram
//
//  Created by peter on 11/30/18.
//  Copyright © 2018 petecit. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController {

    @IBAction func onLogOut(_ sender: Any) {
        let username = PFUser.current()?.username
        
        print("\n" + "..." + username! + " has now logged out...")
        
        PFUser.logOutInBackground { (error) in
            
            // display view controller that needs to shown after successful logout
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
