//
//  CommentsTableViewController.swift
//  EmotiProgect
//
//  Created by user on 8/16/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CommentsTableViewController: UITableViewController {
    
    let identifier = "comCell"
    var commentsArray = [PFObject]()
    
    var item: PFObject!
    
    override func loadView() {
        super.loadView()
        let query = PFQuery(className: "Comment")
        //query.fromLocalDatastore()
        query.whereKey("item", equalTo: self.item)
        query.findObjectsInBackground { (coments, error) in
            if error == nil {
                self.commentsArray = coments!
                self.updateRating(array: self.commentsArray)
                self.tableView.reloadData()
            } else {
                print("Error with text \(String(describing: error))")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        self.navigationItem.title = item[kItemNameFromObgect] as? String
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        
    }
    
    //MARK: - Update rating
    func updateRating(array: [PFObject]) {
        var sumRaiting  = 0
        var count       = 0
        
        for coment in array {
            let number = coment["rating"]
            sumRaiting += number as! Int
            count += 1
        }
        
        var raiting = 0
        if count > 0 {
            raiting = sumRaiting / count
        }
        
        let query = PFQuery(className: "Items")
        query.getObjectInBackground(withId: item.objectId!) { (object, error) in
            if error == nil {
                object!["itemRaiting"] = Int(raiting)
                object?.saveEventually()
            }
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return commentsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CommentTableViewCell
        
        cell.autorNameLabel.text    = commentsArray[indexPath.row]["autorName"] as? String
        cell.commentTextLabel.text  = commentsArray[indexPath.row]["text"] as? String
        
        for i in 0..<(commentsArray[indexPath.row]["rating"] as! Int) {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(7 + (9 * (i + 1))), y: CGFloat((cell.contentView.bounds.height) - 40), width: 9.0, height: 9.0))
            imageView.image = UIImage.init(named: "star")
            cell.contentView.addSubview(imageView)
        }
        
        return cell
    }

    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    

}
