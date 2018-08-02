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

enum buttonTitles: String {
    case add    = "Добавить в избранное"
    case delete = "Удалить из избранного"
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

//    var state: State = .closed
//
//    var runningAnimators: [UIViewPropertyAnimator] = []
//
//    var viewOffset: CGFloat = 8
//
//    func setupViews() {
//        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(onDrag(_:)))
//        //self.itemImageView.addGestureRecognizer(panGesture)
//        self.itemImageShadowsView.addGestureRecognizer(panGesture)
//
//        self.itemImageView.translatesAutoresizingMaskIntoConstraints = false
//        self.itemImageShadowsView.translatesAutoresizingMaskIntoConstraints = false
//        self.cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.topLayoutConstraint.constant = 8
//        self.leftLayoutConstraint.constant = 46
//        self.rightLayoutConstraint.constant = -45
//
//        self.cellBackgroundView.layoutIfNeeded()
//
//        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
//    }
//
//    override func layoutSubviews() {
//        setupViews()
//    }
    
    
    //FIXME: - Need to work with button
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        let localStorege = UserDefaults.standard
        
        let query = PFQuery(className: "Items")
        query.getObjectInBackground(withId: objectId) { (object, error) in
            
            if object != nil && error == nil {
                var array = [String]()
                
                if var tempArray: [String] = localStorege.object(forKey: kForUserDefaultsFavorite) as? [String] {
                    tempArray.insert(object!.objectId!, at: 0)
                    localStorege.set(tempArray, forKey: kForUserDefaultsFavorite)
                    self.favoriteButton.setTitle(buttonTitles.delete.rawValue, for: .normal)
                } else {
                    array.insert(object!.objectId!, at: 0)
                    localStorege.set(array, forKey: kForUserDefaultsFavorite)
                    self.favoriteButton.setTitle(buttonTitles.delete.rawValue, for: .normal)
                }
                localStorege.synchronize()
            } else {
                print("Error to find object")
            }
            
            if self.favoriteButton.titleLabel?.text == buttonTitles.delete.rawValue {
                let objects = localStorege.object(forKey: kForUserDefaultsFavorite)
                
                if let strings = objects {
                    var idArray = strings as! Array<String>
                    print("try to delete from = \(idArray)")
                    let index = idArray.index(of: self.objectId)
                    print("index = ", index!)
                    idArray.remove(at: index!)
                    localStorege.removeObject(forKey: kForUserDefaultsFavorite)
                    localStorege.synchronize()
                    localStorege.set(idArray, forKey: kForUserDefaultsFavorite)
                    localStorege.synchronize()
                    
                    self.favoriteButton.setTitle(buttonTitles.add.rawValue, for: .normal)
                }
            }
        }
    }
    
//    func animateView(to state: State, duration: TimeInterval) {
//
//        guard runningAnimators.isEmpty else {
//            return
//        }
//
//        let basicAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .easeIn, animations: nil)
//
//        basicAnimator.addAnimations {
//            switch state {
//            case .open:
//                self.topLayoutConstraint.constant = self.viewOffset
//                self.leftLayoutConstraint.constant = 0
//                self.rightLayoutConstraint.constant = 0
//
//            case .closed:
//                self.topLayoutConstraint.constant = 8
//                self.leftLayoutConstraint.constant = 46
//                self.rightLayoutConstraint.constant = -45
//
//            }
//            self.cellBackgroundView.layoutIfNeeded()
//        }
//
//        basicAnimator.addCompletion { (animator) in
//            self.runningAnimators.removeAll()
//            self.state = self.state.opposite
//        }
//
//        runningAnimators.append(basicAnimator)
//    }
//
//    @objc func onDrag(_ gesture: UIPanGestureRecognizer) {
//        switch gesture.state {
//        case .began:
//            animateView(to: state.opposite, duration: 0.4)
//        case .changed:
//            let translation = gesture.translation(in: itemImageShadowsView)
//            let fraction = abs(translation.y / viewOffset)
//
//            runningAnimators.forEach { (animator) in
//                animator.fractionComplete = fraction
//            }
//        case .ended:
//            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
//        default:
//            break
//        }
//    }
    
}












