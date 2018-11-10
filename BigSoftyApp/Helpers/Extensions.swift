//
//  Extensions.swift
//  BigSoftyApp
//
//  Created by Kailash on 11/9/18.
//  Copyright © 2018 Kailash. All rights reserved.
//

import UIKit

extension UIView {
    public func anchor(left leftAnchor:NSLayoutXAxisAnchor?, right rightAnchor:NSLayoutXAxisAnchor?,top topAnchor:NSLayoutYAxisAnchor?,bottom bottomAnchor:NSLayoutYAxisAnchor?, paddingLeft leftPadding:CGFloat, paddingRight rightPadding:CGFloat , paddingTop topPadding:CGFloat , paddingBottom bottomPadding:CGFloat, width widthValue:CGFloat?, height heightValue: CGFloat?) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let left = leftAnchor {
            self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let right = rightAnchor {
            self.rightAnchor.constraint(equalTo: right, constant: rightPadding).isActive = true
        }
        
        if let top = topAnchor {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
        
        if let wideVal = widthValue{
            if wideVal > 0 {
                self.widthAnchor.constraint(equalToConstant: wideVal).isActive = true
            }
        }
        
        if let heightVal = heightValue{
            if heightVal > 0 {
                self.heightAnchor.constraint(equalToConstant: heightVal).isActive = true
            }
        }
    }
}
