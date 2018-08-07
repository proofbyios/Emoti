//
//  GlobalScope.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse

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

