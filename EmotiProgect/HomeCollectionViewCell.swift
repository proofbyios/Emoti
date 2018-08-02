//
//  HomeCollectionViewCell.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Parse

enum State {
    case closed
    case open
    
    var opposite: State {
        return self == .open ? .closed : .open
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
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightLayoutConstraint: NSLayoutConstraint!
    
    var objectId: String!
    
    var state: State = .closed
    
    var runningAnimators: [UIViewPropertyAnimator] = []
    
    var viewOffset: CGFloat = 8
    
    func setupViews() {
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(onDrag(_:)))
        self.itemBackgroundView.addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        setupViews()
    }
    
    
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
    
    func animateView(to state: State, duration: TimeInterval) {
        let basicAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .easeIn, animations: nil)
        
        basicAnimator.addAnimations {
            switch state {
            case .open:
                self.topLayoutConstraint.constant = 0
                self.leftLayoutConstraint.constant = 0
                self.rightLayoutConstraint.constant = 0
                
            case .closed:
                self.topLayoutConstraint.constant = 8
                self.leftLayoutConstraint.constant = 46
                self.rightLayoutConstraint.constant = -45
                
            }
            self.cellBackgroundView.layoutIfNeeded()
        }
    }
    
    @objc func onDrag(_ gesture: UIPanGestureRecognizer) {
        print("rraboteat")
        switch gesture.state {
        case .began:
            print("rraboteat")
        case .changed:
            print("rraboteat")
        case .ended:
            print("rraboteat")
        default:
            break
        }
    }
    
}












