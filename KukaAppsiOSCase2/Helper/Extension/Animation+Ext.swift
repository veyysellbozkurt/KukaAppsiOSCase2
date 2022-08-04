//
//  Animation+Ext.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit


extension UIView {
    
    func pulse(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.9
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.12
        flash.fromValue = 1
        flash.toValue = 0.05
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
    
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
    func bounce(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 1)
        animation.toValue = NSNumber(value: 0.3)
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
    
    func animateAddCustomDrinkButton() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 1)
        animation.toValue = NSNumber(value: 0.6)
        animation.duration = 0.15
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
    
    func bouncePaywalButton(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 1)
        animation.toValue = NSNumber(value: 0.89)
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
}
