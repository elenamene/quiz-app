//
//  extensions.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 02/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

enum ButtonStyle {
    case normal
    case pressed
    case correctButton
    case wrongButton
}

extension UIButton {
    func applyStyle(_ style: ButtonStyle) {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 15)
        layer.shadowRadius = 8
        layer.backgroundColor = UIColor.white.cgColor
        titleLabel?.textAlignment = NSTextAlignment.center;
        setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.9), for: .normal)
        contentEdgeInsets = UIEdgeInsets.init(top: 5,left: 5,bottom: 5,right: 5)
        
        switch style {
        case .normal: titleLabel?.font = UIFont.systemFont(ofSize: 15);
                      layer.borderWidth = 0
        case .pressed: titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        case .correctButton: titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
                            layer.borderColor = UIColor(red: 0.3137, green: 0.8471, blue: 0.5451, alpha: 1.0).cgColor;
                            layer.borderWidth = 2
        case .wrongButton: titleLabel?.font = UIFont.systemFont(ofSize: 15);
                           layer.borderColor = UIColor(red:0.96, green:0.35, blue:0.57, alpha:1.0).cgColor
                           layer.borderWidth = 2
        }
    }
}
