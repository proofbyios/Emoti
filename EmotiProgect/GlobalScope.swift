//
//  GlobalScope.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse

public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

enum ButtonCartTitles: String {
    case add    = "Добавить в корзину"
    case delete = "Удалить из корзины"
    
    var opposite: ButtonCartTitles {
        return self.opposite == .add ? .delete : .add
    }
}

let kItemNameFromObgect         = "itemName"
let kItemDescriptionFromObgect  = "itemDescription"
let kItemVideoFromObgect        = "itemVideo"
let kItemPriceFromObgect        = "itemPrice"
let kItemPplFromObgect          = "ppl"
let kItemTimeFromObgect         = "itemTime"
let kItemFromWeatherFromObgect  = "itemFromWeather"
let kItemClothesFromObgect      = "itemClothes"
let kItemWeightFromObgect       = "itemWeight"
let kItemStartFromAgeFromObgect = "itemStartFromAge"
let kItemForPplFromObgect       = "itemForPpl"
let kItemValidDateFromObgect    = "itemValidToDate"
let kItemRaitingFromObgect      = "itemRaiting"
let kItemCatalogFromObgect      = "itemCatalog"

let kForUserDefaultsFavorite    = "favorite"

let hostImageUrlAddres = "http://emoti.back4app.io/"

var itemsInCartArray = [PFObject]()

class Cart {
    static let shared = Cart()
    
    private init(){
        
    }
    
    func addItemToCart(itemId: String) {
        let query = PFQuery(className: "Items")
        query.getObjectInBackground(withId: itemId) { (item, error) in
            if error == nil {
                itemsInCartArray.insert(item!, at: 0)
            }
        }
    }
    
    func deleteItemFromCart(itemId: String) {
        let query = PFQuery(className: "Items")
        query.getObjectInBackground(withId: itemId) { (item, error) in
            if error == nil {
                var index = 0
                for objectItem in itemsInCartArray {
                    if objectItem.objectId! == item!.objectId! {
                        itemsInCartArray.remove(at: index)
                    }
                    index += 1
                }
            }
        }
    }
    
    func goToPayment() {
        print("go to payment")
    }
    
}

extension UIApplication {
    
    var screenShot: UIImage?  {
        return keyWindow?.layer.screenShot
    }
}

extension CALayer {
    
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}

extension UIButton {
    
    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
}


