//
//  AccountViewController.swift
//  EmotiProgect
//
//  Created by user on 8/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import ParseUI
import Parse

enum LoginStatusText: String {
    case logIn  = "Log In"
    case logOut = "Log Out"
}

class AccountViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logInLogOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.current()?.username != nil {
            nameLabel.text = PFUser.current()?.username
        }
        
        imageView.cornerRadiuslEffects(cornerRadius: 64, borderWidth: 1)
        
        let tapHandler = UITapGestureRecognizer.init(target: self, action: #selector(AccountViewController.tapOnImage(_:)))
        
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(tapHandler)
        
        if PFUser.current()?.username != nil {
            let query = PFQuery(className: "_User")
            query.getObjectInBackground(withId: (PFUser.current()?.objectId!)!) { (user, error) in
                if error == nil {
                    let userImageFile = user!["avatar"] as! PFFile
                    userImageFile.getDataInBackground(block: { (imageData, error) in
                        if error == nil {
                            if let imageData = imageData {
                                let image = UIImage(data:imageData)
                                self.imageView.image = image!
                                self.view.layoutIfNeeded()
                            }
                        }
                    })
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current()?.username == nil {
            logInLogOutButton.setTitle(LoginStatusText.logIn.rawValue, for: .normal)
            
            self.imageView.isUserInteractionEnabled = false
        } else {
            nameLabel.isHidden = false
            nameLabel.text = PFUser.current()?.username
            logInLogOutButton.setTitle(LoginStatusText.logOut.rawValue, for: .normal)
            
             self.imageView.isUserInteractionEnabled = true
        }
    
    }
    
    @objc func tapOnImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func logInLogOutAction(_ sender: UIButton) {
        if logInLogOutButton.titleLabel?.text == LoginStatusText.logOut.rawValue {
            PFUser.logOutInBackground()
            self.nameLabel.text = PFUser.current()?.username
            logInLogOutButton.setTitle(LoginStatusText.logIn.rawValue, for: .normal)
            
            self.imageView.image = UIImage(named: "boy-512")
            
            self.view.layoutIfNeeded()
        } else {
            nameLabel.isHidden = true
            let loginVC = PFLogInViewController()
            loginVC.delegate = self
            loginVC.signUpController?.delegate = self
            let image = UIImageView(image: UIImage.init(named: "EMOTI"))
            loginVC.logInView?.logo?.addSubview(image)
            present(loginVC, animated: true, completion: nil)
            
            self.view.layoutIfNeeded()
        }
    }
}

func saveImageToBase(image: UIImage) {
    let imagedata: Data = UIImageJPEGRepresentation(image, 0)!
    let photo: PFFile = PFFile(name: "avatar.jpg", data: imagedata as Data)!
    photo.saveInBackground { (flag, error) in
        if error == nil {
            if PFUser.current()?.username != nil {
                let query = PFQuery(className: "_User")
                query.getObjectInBackground(withId: (PFUser.current()?.objectId!)!) { (user, error) in
                    if error == nil {
                        user?.setObject(photo, forKey: "avatar")
                        user?.saveInBackground()
                    }
                }
            }
        }
    }
}



extension AccountViewController: PFLogInViewControllerDelegate {
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true) {
           // code
        }
        
        if PFUser.current()?.username != nil {
            let query = PFQuery(className: "_User")
            query.getObjectInBackground(withId: (PFUser.current()?.objectId!)!) { (user, error) in
                if error == nil {
                    let userImageFile = user!["avatar"] as! PFFile
                    userImageFile.getDataInBackground(block: { (imageData, error) in
                        if error == nil {
                            if let imageData = imageData {
                                let image = UIImage(data:imageData)
                                self.imageView.image = image!
                                self.view.layoutIfNeeded()
                            }
                        }
                    })
                }
            }
        }
    }
}

extension AccountViewController: PFSignUpViewControllerDelegate {
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        signUpController.dismiss(animated: true, completion: nil)
    }
}

extension AccountViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = img
        picker.dismiss(animated: true, completion: nil)
        
        saveImageToBase(image: img)
    }
}

extension AccountViewController: UINavigationControllerDelegate {
    
}
