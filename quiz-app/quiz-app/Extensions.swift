//
//  extensions.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 02/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func applyBasicStyle() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 15)
        layer.shadowRadius = 8
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderWidth = 0
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.9), for: .normal)
    }
    func applyGradientStyle(colorOne: UIColor, colorTwo: UIColor) {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 15)
        layer.shadowRadius = 8
        setTitleColor(UIColor.white, for: .normal)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.cornerRadius = 8
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView {
    func applyGradient(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
        layer.masksToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
