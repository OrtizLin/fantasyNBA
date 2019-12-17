//
//  UIView.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//
import UIKit

extension UIView {
    func themeButtonStyle(isSolid: Bool) {
        if isSolid {
            self.layer.cornerRadius = 16
            self.backgroundColor = .white
        } else {
            self.layer.cornerRadius = 16
            self.layer.borderColor = UIColor(red:0, green:0.64, blue:0.87, alpha:1).cgColor
        }
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
}
