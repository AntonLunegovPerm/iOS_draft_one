//
//  Brandbook.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit

struct BrandBook {
    struct TextField {
        static let font = AppFonts.Body.B2
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 44.0
        struct Colors {

            static let background   = R.color.mainColor()!
            static let text         = R.color.mainColor()!
            static let error        = R.color.mainColor()!
            static let placeholder  = R.color.mainColor()!
            static let tint         = R.color.mainColor()!
        }
    }
    
    struct Label {
        struct Colors {
            static let blackText        = R.color.mainColor()!
            static let onlyBlackText    = R.color.mainColor()!
            static let grayText         = R.color.mainColor()!
            static let errorText        = R.color.mainColor()!
        }
    }
    
    struct Button {
        static let cornerRadius: CGFloat = 12.0
        static let bigButtonCornerRadius: CGFloat = 16.0
    }
    
    /// Свойства для кнопок только с иконками и для реализации иконками
    struct Icon {
        struct Size {
            static let small: CGFloat = 24.0
            static let medium: CGFloat = 40.0
            static let big: CGFloat = 64.0
        }
        struct Colors {
            static let smallBackground = UIColor.clear
            static let mediumBackground     = R.color.mainColor()!
            static let bigBackground        = R.color.mainColor()!
            static let bigButtonBackground  = R.color.mainColor()!
        }
    }
    
    struct TextView {
        static let font = AppFonts.Body.B2
        
        struct Colors {
            static let linkColor = R.color.mainColor()!
            static let textColor = R.color.mainColor()!
            static let grayTextColor = R.color.mainColor()!
        }
    }
    
    struct Cards {
        static let cornerRadius: CGFloat = 16.0
    }
    
    struct BackgroundView {
 
    }
    
    struct PageControl {
        struct Colors {
            static let currentIndicatorTint = R.color.mainColor()!
            static let indicatorTint = R.color.mainColor()!
        }
    }
    
    struct Switch {
        struct Colors {
            static let onTint = R.color.mainColor()!
        }
    }
}
