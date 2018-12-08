//
//  SelectPhotoViewController.swift
//  ios-instagram
//
//  Created by peter on 12/7/18.
//  Copyright © 2018 petecit. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoSelectedImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var photoSelected : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func endEditingCaption(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func loadCameraPhotoLibrary(_ sender: Any) {
        self.selectPhoto()
    }
    
    @IBAction func postPhoto(_ sender: Any) {
        let caption = captionTextField.text ?? ""
        let image = photoSelectedImageView.image
        if (!photoSelected) {
            let alertController = UIAlertController(title: "Photo Not Chosen", message: "Please choose a photo to create a new post.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            alertController.addAction(dismissAction)
            present(alertController, animated: true) { }
            return;
        }
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        self.performSegue(withIdentifier: "PostPhotoSegue", sender: nil)
    }
    
    @IBAction func cancelNewPost(_ sender: Any) {
        self.performSegue(withIdentifier: "PostPhotoSegue", sender: nil)
    }
    
    func selectPhoto() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            //print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        // let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        photoSelectedImageView.image = editedImage
        photoSelected = true
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
}
