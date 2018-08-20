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
    let imagedata = UIImagePNGRepresentation(image)
    let photo = PFFile(name: "avatar.png", data: imagedata!)
    
    let query = PFQuery(className: "User")
    query.getObjectInBackground(withId: "chBYWj33FD") { (user, error) in
        if error == nil {
            let acl = PFACL.init(user: user! as! PFUser)
            acl.setWriteAccess(true, for: user as! PFUser)
            user!.acl = acl
            user!["photo"] = photo
            user!.saveEventually()
        } else {
            print(error!)
        }
    }
    
}

extension AccountViewController: PFLogInViewControllerDelegate {
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true) {
           // code
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
