//
//  CartViewController.swift
//  EmotiProgect
//
//  Created by user on 8/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse

let identifier = "cartCell"

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        let blur = UIBlurEffect.init(style: .light)
        let visualEffects = UIVisualEffectView.init(effect: blur)
        visualEffects.frame = self.view.bounds
        self.view.addSubview(visualEffects)
        self.view.sendSubview(toBack: visualEffects)
        
        tableView.backgroundColor = UIColor.clear

        tableView.register(UINib.init(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        tableView.separatorStyle = .none
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
        
    }
    
    
    @IBAction func clearCartAction(_ sender: UIButton) {
        itemsInCartArray.removeAll()
        tableView.reloadData()
    }
        
    
    
}
