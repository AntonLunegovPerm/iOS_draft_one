//
//  Brandbook.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit

class Brandbook {
    
    /// example: Brandbook.Font.init(.MontserratLight, size: .standard(.h1))
    /// example: Brandbook.Font.init(.MontserratLight, size: .custom(9))
    ///
    struct Font {
        
        enum FontName: String {
            case MontserratLight        = "Montserrat-Light"
            case MontserratMedium       = "Montserrat-Medium"
            case MontserratRegular      = "Montserrat-Regular"
            case MontserratSemibold     = "Montserrat-SemiBold"
        }
        
        enum FontSize {
            case standard(StandardSize)
            case custom(Double)
            
            var value: Double {
                switch self {
                case .standard(let size):
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        return size.mobile
                    } else {
                        return size.tablet
                    }
                case .custom(let customSize):
                    return customSize
                }
            }
        }
        
        enum StandardSize {
            case h1
            case h2
            case h3
            case h4
            case h5
            case body
            case subheadline
            case caption1
            case caption2
            case button
            
            var tablet: Double {
                switch self {
                case .h1:
                    return 40.0
                case .h2:
                    return 24.0
                case .h3:
                    return 20.0
                case .h4:
                    return 16.0
                case .h5:
                    return 14.0
                case .body:
                    return 14.0
                case .subheadline:
                    return 12.0
                case .caption1:
                    return 12.0
                case .caption2:
                    return 10.0
                case .button:
                    return 16.0
                }
            }
            
            var mobile: Double {
                switch self {
                case .h1:
                    return 36.0
                case .h2:
                    return 24.0
                case .h3:
                    return 20.0
                case .h4:
                    return 16.0
                case .h5:
                    return 14.0
                case .body:
                    return 14.0
                case .subheadline:
                    return 12.0
                case .caption1:
                    return 12.0
                case .caption2:
                    return 10.0
                case .button:
                    return 16.0
                }
            }
        }
        
        var type: FontName
        var size: FontSize
        
        init(_ type: FontName, size: FontSize) {
            self.type = type
            self.size = size
        }
        
        var instance: UIFont {
            
            guard let font = UIFont(name: type.rawValue, size: CGFloat(size.value)) else {
                return UIFont.systemFont(ofSize: CGFloat(size.value))
            }
            
            return font
        }
    }
    
    class Colors {
        
        class Tasks {
            @nonobjc class var c6385FD: UIColor {
                return .red
                // TODO: swifterSwift
//                return UIColor(hexString: "6385FD") ?? UIColor.clear
            }
        }
    }
}
            
