//
//  CustomButton.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/3/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
/// Custom Button
class CustomButton  : UIButton {
    /**
     setup border width for button
     - parameter borderWidth:   border width value (float)
     
     */
    @IBInspectable var  borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    /**
     setup circle button (corner)
     - parameter cornerRadius:   cornder radius value (float)
     
     */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    /**
     setup button border color
     - parameter borderColor:   border color value (UiColor)
     
     */
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
}

