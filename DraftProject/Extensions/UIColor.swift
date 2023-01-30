//
//  UIColor.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import UIKit

extension UIColor {
    var isDark: Bool {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if !self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return false
        }
        let brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        return brightness < 0.8 && a > 0.5
    }
    
    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red *= 255.0
        green *= 255.0
        blue *= 255.0
        alpha *= 255.0
        
        var hex = 0
        hex = (Int(alpha) << 24) | hex
        hex = (Int(red) << 16) | hex
        hex = (Int(green) << 8) | hex
        hex = Int(blue) | hex
        return String(format: "%2X", hex)
    }
    
    var hexNoAlphaString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        red *= 255.0
        green *= 255.0
        blue *= 255.0
        
        var hex = 0
        hex = (Int(red) << 16) | hex
        hex = (Int(green) << 8) | hex
        hex = Int(blue) | hex
        return String(format: "%2X", hex)
    }
    
    convenience init?(hexString: String) {
        var _hexString = hexString;
        if _hexString.isEmpty {
            return nil
        }
        
        if _hexString.hasPrefix("#") {
            _hexString.remove(at: _hexString.startIndex)
        }
        let x = strtoul(_hexString, nil, 16)
        let hasAlpha = _hexString.count > 6
        self.init(hex: x, hasAlpha: hasAlpha)
    }
    
    convenience init(hex: UInt, hasAlpha: Bool = false) {
        let r, g, b, a: UInt
        r = (hex >> 16) & 0xFF
        g = (hex >> 8) & 0xFF
        b = hex & 0xFF
        a = hasAlpha ? ((hex >> 24) & 0xFF) : 0xFF
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            if cString.count == 3 {
                cString = String(cString[0]) + String(cString[0]) + String(cString[1]) + String(cString[1]) + String(cString[2]) + String(cString[2])
            } else {
                self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
                return
            }
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(rgb: Int(rgbValue))
    }
    
    public convenience init?(_ rgba: String?) {
        guard let rgba = rgba, let color = try? UIColor(rgba) else {
            return nil
        }
        self.init(cgColor: color.cgColor)
    }
}

