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
    
    var rgbComponent: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r, g, b, a)
        }
        return (0, 0, 0, 0)
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


extension UIView {
    func addGradientLayer(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        self.layer.addSublayer(gradientLayer)
    }
}

extension UILabel {
    func outline(strokeWidth: Float, strokeColor: UIColor) {
        let strokeAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: strokeColor,
            NSAttributedString.Key.strokeWidth: strokeWidth,
        ]
        
        if let currentAttribute = self.attributedText {
            let outlineAttribute = NSMutableAttributedString(attributedString: currentAttribute)
            
            outlineAttribute.addAttributes(
                strokeAttribute,
                range: NSRange(location: 0, length: self.text?.count ?? 0)
            )
            self.attributedText = outlineAttribute
        }
       
    }
}

extension UserDefaults {
    func color(forKey key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else { return nil }

        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch let error {
            print("error: \(error.localizedDescription)")
            return nil
        }

    }

    func set(_ value: UIColor?, forKey key: String) {
        guard let color = value else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
    }
}

func getUserSetting() -> (fontName: UIFont, fontColor: UIColor) {
    let fontName = UserDefaults.standard.string(forKey: "UserFontName") ?? "Arial"
    let fontSize = CGFloat(UserDefaults.standard.float(forKey: "UserFontSize"))
    let fontColor = UserDefaults.standard.color(forKey: "UserColor") ?? UIColor.black
    
    let font = UIFont(name: fontName, size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
    return (font, fontColor)
}
