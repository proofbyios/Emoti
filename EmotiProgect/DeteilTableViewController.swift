//
//  DeteilTableViewController.swift
//  EmotiProgect
//
//  Created by user on 8/7/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse
import SDWebImage

class DeteilTableViewController: UITableViewController {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemCommentsButton: UIButton!
    
    var item: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = item[kItemNameFromObgect] as? String
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(image: UIImage.init(named: "cart.png"), style: .plain, target: self, action: #selector(cart))]
        
        let imageName = item["itemImage"] as! String
        self.itemImageView.sd_setImage(with: URL(string: hostImageUrlAddres + imageName)) { (img, err, cashType, url) in
            
        }
        
        self.itemDescriptionTextView.text = item[kItemDescriptionFromObgect] as! String
        self.itemPriceLabel.text = "Стоимость: \(String(describing: item[kItemPriceFromObgect] as! String)) грн."
        
        let reiting = item[kItemRaitingFromObgect] as! Int
        
        for i in 0..<reiting {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(1 + (17 * (i + 1))), y: CGFloat(cellView.bounds.height - 355), width: 12.0, height: 12.0))
            imageView.image = UIImage.init(named: "star")
            cellView.addSubview(imageView)
        }
        
    }
    
    //MARK: - Cart
    @objc func cart() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "cartViewController")

        viewController.modalPresentationStyle = .popover
        self.present(viewController, animated: true) {

        }

        let popover = UIPopoverPresentationController.init(presentedViewController: self, presenting: viewController)
        popover.barButtonItem = self.navigationItem.leftBarButtonItem

    }

    @IBAction func itemCommentsButtonAction(_ sender: UIButton) {
        
    }
    

    @IBAction func addComentAlertAction(_ sender: UIButton) {
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self as CustomAlertViewDelegate
        self.present(customAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comments" {
            let destinationVC = segue.destination as! CommentsTableViewController
            destinationVC.item = self.item
        }
    }
    
    
}

extension DeteilTableViewController: CustomAlertViewDelegate {
    
    func okButtonTapped(selectedOption: String, textFieldValue: String) {
        print("okButtonTapped with \(selectedOption) option selected")
        print("TextField has value: \(textFieldValue)")
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
