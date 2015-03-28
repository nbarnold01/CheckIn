//
//  Colors.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/28/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    
    
    
    class func colorWithRGBHex(hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    

}

var Black = UIColor.colorWithRGBHex(0x3A3A3A, alpha: 1)
var Hallogen = UIColor.colorWithRGBHex(0xEEFCFF, alpha: 1)
var White = UIColor.colorWithRGBHex(0xFFFFFF, alpha: 1)
var Blue = UIColor.colorWithRGBHex(0xDAF3F8, alpha: 1)

