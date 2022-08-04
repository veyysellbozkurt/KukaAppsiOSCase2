//
//  UIColor+Ext.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit


extension UIColor {
    static let primary                      = UIColor.init(red: 245, green: 245, blue: 245)
    static let cellBackground               = UIColor.init(red: 250, green: 250, blue: 250)
    static let navigationLargeTitle         = UIColor.init(red: 0, green: 0, blue: 0)
    static let navigationTitle              = UIColor.init(red: 6, green: 6, blue: 6)
    static let tableViewSeparator           = UIColor.init(red: 220, green: 220, blue: 220)
    static let normalLabel                  = UIColor.init(red: 55, green: 55, blue: 55)
    static let weakLabel                    = UIColor.init(red: 189, green: 189, blue: 189)
    static let itemBackground               = UIColor.init(red: 249, green: 249, blue: 249)
    static let cellSelectionTint            = UIColor.init(red: 230, green: 230, blue: 230)
}


extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329 //color #999999 if string has wrong format
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue)
        }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, reqAlpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: reqAlpha)
    }
    
}
