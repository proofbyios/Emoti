//
//  CartViewController.swift
//  EmotiProgect
//
//  Created by user on 8/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse
import ParseUI

let identifier = "cartCell"

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var totallabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmButton.setGradientBackground(colorOne: UIColor.blue, colorTwo: UIColor.init(red: 251.0/255.0, green: 20.0/255.0, blue: 255.0/255.0, alpha: 1))
        self.confirmButton.cornerRadiuslEffects(cornerRadius: 15.0, borderWidth: 0)
        
        self.view.backgroundColor = UIColor.clear
        
        let blur = UIBlurEffect.init(style: .light)
        let visualEffects = UIVisualEffectView.init(effect: blur)
        visualEffects.frame = self.view.bounds
        self.view.addSubview(visualEffects)
        self.view.sendSubview(toBack: visualEffects)
        
        tableView.backgroundColor = UIColor.clear

        tableView.register(UINib.init(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        tableView.separatorStyle = .none
        
        var sum = 0
        
        for item in itemsInCartArray {
            sum += Int(item[kItemPriceFromObgect] as! String)!
        }
        
        self.totallabel.text = "Всего в корзине \(itemsInCartArray.count) шт. На сумму \(sum) грн."
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundImageView = UIImageView.init(frame: self.view.bounds)
        backgroundImageView.image = UIApplication.shared.screenShot
        self.view.addSubview(backgroundImageView)
        self.view.sendSubview(toBack: backgroundImageView)
        
        if itemsInCartArray.count == 0 {
            totallabel.text             = "Корзина пуста"
            confirmButton.isHidden      = true
            clearButton.isHidden        = true
            phoneTextField.isHidden     = true
        }
        
        if PFUser.current()?.username != nil {
            let query = PFQuery(className: "_User")
            query.getObjectInBackground(withId: (PFUser.current()?.objectId!)!) { (user, error) in
                if error == nil {
                    let phone = user!["phone"] as! String
                    if phone.isEmpty {
                        self.phoneTextField.isHidden = false
                    } else {
                        self.phoneTextField.isHidden = true
                    }
                }
            }
        }
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInCartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CartTableViewCell
        
        let item = itemsInCartArray[indexPath.row]
        
        let imageName = item["itemImage"] as! String
        cell.cellImageView.sd_setImage(with: URL(string: hostImageUrlAddres + imageName)) { (img, err, cashType, url) in
            
        }
        
        cell.cellItemNameLabel.text     = item[kItemNameFromObgect] as? String
        cell.cellItemPriceLabel.text    = "\(item[kItemPriceFromObgect]!) грн."
        
        cell.cellImageView.cornerRadiuslEffects(cornerRadius: 5.0, borderWidth: 1.0)
       
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func goToOrderConfirm(_ sender: UIButton) {
        if PFUser.current()?.username == nil {
            login()
        } else {
            let query = PFQuery(className: "_User")
            query.getObjectInBackground(withId: (PFUser.current()?.objectId!)!) { (user, error) in
                if error == nil {
                    user!["phone"] = self.phoneTextField.text
                    user!.saveInBackground()
                }
            }
        }
    }
    
    
    @IBAction func clearCartAction(_ sender: UIButton) {
        itemsInCartArray.removeAll()
        tableView.reloadData()
        totallabel.text             = "Корзина пуста"
        confirmButton.isHidden      = true
        clearButton.isHidden        = true
        phoneTextField.isHidden     = true
        
    }
        
    func login() {
        let loginVC = PFLogInViewController()
        let signUp = PFSignUpViewController()
        signUp.delegate = self
        loginVC.delegate = self
        present(loginVC, animated: true, completion: nil)
    }
    
}

extension CartViewController: PFLogInViewControllerDelegate {
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true, completion: nil)
    }
}

extension CartViewController: PFSignUpViewControllerDelegate {
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        signUpController.dismiss(animated: true, completion: nil)
    }
}

extension CartViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let lettersSet = NSCharacterSet.letters
        let rangeResult = string.rangeOfCharacter(from: lettersSet)
        
        if rangeResult != nil {
            return false
        }
        
        var fullString = textField.text ?? ""
        fullString.append(string)
        if range.length == 1 {
            textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
        } else {
            textField.text = format(phoneNumber: fullString)
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
    guard !phoneNumber.isEmpty else { return "" }
    guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
    let r = NSString(string: phoneNumber).range(of: phoneNumber)
    var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
    
    if number.count > 10 {
        let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
        number = String(number[number.startIndex..<tenthDigitIndex])
    }
    
    if shouldRemoveLastDigit {
        let end = number.index(number.startIndex, offsetBy: number.count-1)
        number = String(number[number.startIndex..<end])
    }
    
    if number.count < 7 {
        let end = number.index(number.startIndex, offsetBy: number.count)
        let range = number.startIndex..<end
        number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
        
    } else {
        let end = number.index(number.startIndex, offsetBy: number.count)
        let range = number.startIndex..<end
        number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
    }
    
    return number
}


