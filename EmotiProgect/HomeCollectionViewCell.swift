//
//  HomeCollectionViewCell.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse

//enum State {
//    case closed
//    case open
//
//    var opposite: State {
//        return self == .open ? .closed : .open
//    }
//}

enum ButtonFavoriteTitles: String {
    case add    = "Добавить в избранное"
    case delete = "Удалить из избранного"
    
    var opposite: ButtonFavoriteTitles {
        return self.opposite == .add ? .delete : .add
    }
}

enum ButtonCartTitles: String {
    case add    = "Добавить в корзину"
    case delete = "Удалить из корзины"
    
    var opposite: ButtonCartTitles {
        return self.opposite == .add ? .delete : .add
    }
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var cellBackgroundView: UIView!    
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImageShadowsView: UIView!
    @IBOutlet weak var itemBackgroundImageView: UIImageView!
    
    @IBOutlet weak var cartButton: UIButton!
    
    var objectId: String!
    
    @IBAction func addOrDeleteFromCartAction(_ sender: UIButton) {
        if self.cartButton.titleLabel?.text == ButtonCartTitles.add.rawValue {
            Cart.shared.addItemToCart(itemId: objectId)
            self.cartButton.setTitle(ButtonCartTitles.delete.rawValue, for: .normal)
        } else {
            Cart.shared.deleteItemFromCart(itemId: objectId)
            self.cartButton.setTitle(ButtonCartTitles.add.rawValue, for: .normal)
        }
    }
    
    
}












