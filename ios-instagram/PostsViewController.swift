//
//  HomeFeedViewController.swift
//  ios-instagram
//
//  Created by peter on 11/30/18.
//  Copyright © 2018 petecit. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var logoutButon: UIButton!
    @IBOutlet weak var postsTableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var posts: [Post] = []
    
    @IBAction func onSignOut(_ sender: Any) {
        let username = PFUser.current()?.username
        
        print("\n" + "..." + username! + " has now logged out...")
        
        PFUser.logOutInBackground { (error) in
            
            if (error != nil) {
                print(error.debugDescription)
            }
            
            // display view controller that needs to shown after successful logout
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
    }
    
    @IBAction func onCreateNewPost(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateNewPostSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup pull-to-refresh functionality
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPostsData), for: .valueChanged)
        postsTableView.insertSubview(refreshControl, at: 0)
        
        // setup delegate, data source, and dimensions
        postsTableView.delegate = self as UITableViewDelegate
        postsTableView.dataSource = self as UITableViewDataSource
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 280
        postsTableView.rowHeight = 280
        
        // retrieve posts and update table view
        // Retrieve posts and update table view
        fetchPostsData()
        postsTableView.reloadData()
    }
    
    @objc func fetchPostsData() {
        
        // Create a new Parse query and specify the parameters of the request
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.limit = 20
        
        // Fetch the data asynchronously from Parse
        query?.findObjectsInBackground(block: { (posts, error) in
            // If we were able to retrieve the data...
            if let posts = posts {
                // ...populate the array of posts declared in this class
                self.posts = posts as! [Post]
                // ...and refresh the table view
                self.postsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
                // Otherwise, find out what went wrong.
            else {
                print(error.debugDescription)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.indexPath = indexPath
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.postImageView.image = UIImage(data: data!)
                }
            }
        }
        cell.captionLabel.text = post.caption
        return cell
    }

}
