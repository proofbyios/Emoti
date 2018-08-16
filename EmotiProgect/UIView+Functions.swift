//
//  UIView+Functions.swift
//  EmotiProgect
//
//  Created by user on 7/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

extension UIView {
    
    func cornerRadiuslEffects(cornerRadius: CGFloat, borderWidth: CGFloat) {
        self.layer.cornerRadius     = cornerRadius
        self.layer.borderWidth      = borderWidth
        self.layer.borderColor      = UIColor.clear.cgColor
        self.layer.masksToBounds    = true;
    }
    
    func shadowEffects(shadowRadius: CGFloat) {
        self.layer.shadowColor      = UIColor.lightGray.cgColor
        self.layer.shadowRadius     = shadowRadius
        self.layer.shadowOffset     = CGSize(width:0.0, height: 5.0)
        self.layer.shadowOpacity    = 1.0
        self.layer.masksToBounds    = false;
        self.layer.shadowPath       = UIBezierPath.init(rect:self.bounds).cgPath
        self.layer.shouldRasterize  = true
    }
    
    func blurImage() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
            
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
        self.sendSubview(toBack: blurEffectView)
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func randomColor() -> UIColor {
        let r: CGFloat = CGFloat(arc4random() % 256) / CGFloat(255)
        let g: CGFloat = CGFloat(arc4random() % 256) / CGFloat(255)
        let b: CGFloat = CGFloat(arc4random() % 256) / CGFloat(255)
        
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}


