//
//  UIView+Ext.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit


extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4, maskedCorners: CACornerMask = [.layerMaxXMaxYCorner,
                                                                               .layerMaxXMinYCorner,
                                                                               .layerMinXMaxYCorner,
                                                                               .layerMinXMinYCorner]) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
    }
    
    func addBorderLine(width: CGFloat = 1, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func makeCircle() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func addShadow(
        cornerRadius: CGFloat = 16,
        shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
        shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0),
        shadowOpacity: Float = 0.3,
        shadowRadius: CGFloat = 5) {
            
            layer.cornerRadius = cornerRadius
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
}
