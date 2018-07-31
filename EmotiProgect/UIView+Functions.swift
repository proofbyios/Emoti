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
        self.layer.shadowOffset     = CGSize(width:3.0, height: 2.0)
        self.layer.shadowOpacity    = 1.0
        self.layer.masksToBounds    = true;
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
    
}


