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
    @IBOutlet weak var itemImageShadowsView: UIView!
    @IBOutlet weak var itemBackgroundImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    //FIXME: - Need to work with button
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        let query = PFQuery(className: "Items")
        query.getObjectInBackground(withId: objectId) { (object, error) in
            
            if object != nil && error == nil {
                let localStorege = UserDefaults.standard
                var array = [String]()
                
                if var tempArray: [String] = localStorege.object(forKey: kForUserDefaultsFavorite) as? [String] {
                    tempArray.insert(object!.objectId!, at: 0)
                    localStorege.set(tempArray, forKey: kForUserDefaultsFavorite)
                } else {
                    array.insert(object!.objectId!, at: 0)
                    localStorege.set(array, forKey: kForUserDefaultsFavorite)
                }
            } else {
                print("Error to find object")
            }
        
        }
    }
}
    
func addOrDelleteFromFavorite(button: UIButton, objectId: String, flag: Bool, buttonText: String) {
    
}

