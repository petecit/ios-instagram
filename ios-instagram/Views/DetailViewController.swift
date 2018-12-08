//
//  DetailViewController.swift
//  ios-instagram
//
//  Created by peter on 12/8/18.
//  Copyright © 2018 petecit. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateViewData()
    }
    
    func populateViewData() {
        if let imageFile : PFFile = post?.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    self.detailImageView.image = UIImage(data: data!)
                }
            }
        }
        captionLabel.text = post?.caption
        timeStampLabel.text = formatDateString((post?.createdAt)!)
    }
    
    func formatDateString(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToPhotoFeed", sender: nil)
    }
    
}
