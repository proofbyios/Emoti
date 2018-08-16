//
//  CustomAlertViewDelegate.swift
//  EmotiProgect
//
//  Created by user on 8/16/18.
//  Copyright © 2018 user. All rights reserved.
//

protocol CustomAlertViewDelegate: class {
    func okButtonTapped(selectedOption: String, textFieldValue: String)
    func cancelButtonTapped()
}
