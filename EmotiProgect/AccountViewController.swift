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

    @IBOutlet weak var logInLogOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current()?.username == nil {
            logInLogOutButton.setTitle(LoginStatusText.logIn.rawValue, for: .normal)
        } else {
            logInLogOutButton.setTitle(LoginStatusText.logOut.rawValue, for: .normal)
        }
    }

    
    @IBAction func logInLogOutAction(_ sender: UIButton) {
        if logInLogOutButton.titleLabel?.text == LoginStatusText.logOut.rawValue {
            PFUser.logOutInBackground()
            logInLogOutButton.setTitle(LoginStatusText.logIn.rawValue, for: .normal)
        } else {
            let loginVC = PFLogInViewController()
            loginVC.delegate = self
            loginVC.signUpController?.delegate = self
            let image = UIImageView(image: UIImage.init(named: "EMOTI"))
            loginVC.logInView?.logo?.addSubview(image)
            present(loginVC, animated: true, completion: nil)
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
