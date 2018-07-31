//
//  HomeViewController.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let identifier = "HomeCollectionViewCell"
    
    var itemsArray = [PFObject]()
    
    override func loadView() {
        super.loadView()
        
        let query = PFQuery(className: "Items")
        query.findObjectsInBackground { (items, error) in
            if error == nil {
                if let returnedItems = items {
                    self.itemsArray = returnedItems
                    self.collectionView.reloadData()
                }
            } else {
                print("Error to find objects in base")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Emoti"

        collectionView.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        
    }

    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeCollectionViewCell
        
        cell.objectId = itemsArray[indexPath.row].objectId
        
        cell.itemNameLabel.text = itemsArray[indexPath.row][kItemNameFromObgect] as? String
        cell.itemPriceLabel.text = String(format: "Cтоимость: %@ грн.", self.itemsArray[indexPath.row][kItemPriceFromObgect] as! String)
        
        let imageName = itemsArray[indexPath.row]["itemImage"] as! String
        cell.itemImageView?.sd_setImage(with: URL(string: hostImageUrlAddres + imageName), completed: { (img, err, cashType, url) in
            //FIXME: - Use Cash here
            //self.view.backgroundColor = UIColor.init(patternImage: img!)
            cell.cellBackgroundView.backgroundColor = UIColor.init(patternImage: img!)
        })
        
        cell.cellBackgroundView.blurImage()
        cell.itemBackgroundView.cornerRadiuslEffects(cornerRadius: 5.0, borderWidth: 1.0)
        cell.itemImageView.cornerRadiuslEffects(cornerRadius: 5.0, borderWidth: 1.0)
        cell.itemImageView.shadowEffects(shadowRadius: 5.0)
        
        let reiting = self.itemsArray[indexPath.row][kItemRaitingFromObgect] as! Int
        
        for i in 0..<reiting {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(1 + (12 * (i + 1))), y: CGFloat(cell.itemBackgroundView.bounds.height - 60), width: 12.0, height: 12.0))
            imageView.image = UIImage.init(named: "star")
            cell.itemBackgroundView.addSubview(imageView)
        }
        
        return cell
    }
    

}
