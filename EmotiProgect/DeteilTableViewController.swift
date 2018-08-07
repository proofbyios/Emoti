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

    @IBOutlet weak var itemImageView: UIImageView!
    
    var item: PFObject!
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = item[kItemNameFromObgect] as? String
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(image: UIImage.init(named: "cart.png"), style: .plain, target: self, action: #selector(cart))]
        
        let imageName = item["itemImage"] as! String
        self.itemImageView.sd_setImage(with: URL(string: hostImageUrlAddres + imageName)) { (img, err, cashType, url) in
            
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

    
}
