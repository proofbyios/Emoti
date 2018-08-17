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
        query.fromLocalDatastore()
        query.whereKey("item", equalTo: self.item)
        query.findObjectsInBackground { (coments, error) in
            if error == nil {
                print("Comments = \(String(describing: coments!))")
                self.commentsArray = coments!
                self.tableView.reloadData()
            } else {
                print("Error with text \(String(describing: error))")
            }
        }
        print(self.commentsArray)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        self.navigationItem.title = item[kItemNameFromObgect] as? String
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
        
        cell.autorNameLabel.text = "rerer"
        
        return cell
    }

    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    

}
