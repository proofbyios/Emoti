//
//  HomeCollectionViewCell.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse

class HomeCollectionViewCell: UICollectionViewCell {
    
    var objectId: String!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var cellBackgroundView: UIView!    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    //FIXME: - Need to work with button
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        let query = PFQuery(className: "Items")
        query.getObjectInBackground(withId: objectId) { (object, error) in
            if object != nil && error == nil {
                object![kItemIsFavoritFromObgect] = true
                object!.saveEventually()
            } else {
                print("Error to find object")
            }
        }
    }
    
    
}
