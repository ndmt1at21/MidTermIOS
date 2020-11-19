//
//  Components.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit

extension UITextField {
    func shadow(_ x: Double, _ y: Double, _ radius: CGFloat, _ color: CGColor) {
        let offset = CGSize(width: x, height: y)
        layer.shadowOpacity = 1
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowColor = color
    }
    
    func border(_ borderWidth: CGFloat, _ style: BorderStyle, _ color: CGColor) {
        layer.borderWidth = borderWidth
        borderStyle = style
        layer.borderColor = color
    }
    
    func cornerRadiusAndShadow() {
        self.border(0, .none, UIColor("#000", 0.1).cgColor)
        self.shadow(0, 0, 10, UIColor("#000", 0.2).cgColor)
        self.layer.cornerRadius = self.frame.height / 4
    }
}

extension UIColor {
    convenience init(_ hex: String, _ alpha: CGFloat) {
        if !hex.hasPrefix("#") {
            self.init()
            return
        }
        
        let index = hex.index(after: hex.startIndex);
        let hexStr = String(hex[index...])
        let hexColor = UInt32(hexStr, radix: 16)
                            
        if (hexColor == nil) {
            self.init()
            return
        }
        
        let red = CGFloat((hexColor! & 0xFF0000) >> 16) / 255
        let green = CGFloat((hexColor! & 0x00FF00) >> 8) / 255
        let blue = CGFloat((hexColor! & 0x0000FF)) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


extension CALayer {
    func shadow(_ x: Double, _ y: Double, _ radius: CGFloat, _ color: CGColor) {
        let offset = CGSize(width: x, height: y)
        self.shadowOpacity = 1
        shadowOffset = offset
        shadowRadius = radius
        shadowColor = color
    }
}
