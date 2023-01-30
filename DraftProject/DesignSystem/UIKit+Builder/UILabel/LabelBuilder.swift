//
//  LabelBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class LabelBuilder: LabelBuilderType {

    private var label: UILabel

    init(_ label: UILabel = UILabel()) {
        self.label = label
    }

    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        LabelBuilder() as! Self
    }

    func build() -> UILabel {
        return label
    }
    
    // MARK: - UIViewBuilderType
    
    func useAutoLayout() -> Self {
        label.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> Self {
        label.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        label.layer.cornerRadius = radius
        label.clipsToBounds = true
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        label.layer.borderWidth = width
        label.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - LabelBuilderType
    func setFont(_ font: UIFont) -> Self {
        label.font = font
        return self
    }
    
    func setTextColor(_ color: UIColor) -> Self {
        label.textColor = color
        return self
    }

    func setText(_ text: String) -> Self {
        label.text = text
        return self
    }

    func setNumberOfLines(_ number: Int) -> Self {
        label.numberOfLines = number
        return self
    }

    func setAlignment(_ alignment: NSTextAlignment) -> Self {
        label.textAlignment = alignment
        return self
    }
}

// MARK: - StyleBuilder
extension LabelBuilder: StyleBuilder {
    func setStyle(_ style: LabelStyle) -> Self {
        switch style {
            case .error:
                label.font = Style.Error.font
                label.textColor = Style.Error.colorText
                label.textAlignment = .left
            case .mainRegistration:
                label.font = Style.MainRegistration.font
                label.textColor = Style.MainRegistration.colorText
            case .infoRegistration:
                label.font = Style.InfoRegistration.font
                label.textColor = Style.InfoRegistration.colorText
            case .infoBlackB2:
                label.font = Style.InfoBlackB2.font
                label.textColor = Style.InfoBlackB2.textColor
                label.textAlignment = .left
                label.numberOfLines = 0
            case .infoGrayB2:
                label.font = Style.InfoGrayB2.font
                label.textColor = Style.InfoGrayB2.textColor
                label.textAlignment = .left
                label.numberOfLines = 0
            case .infoGrayC3:
                label.font = Style.InfoGrayC3.font
                label.textColor = Style.InfoGrayC3.textColor
                label.textAlignment = .left
            case .titleH2:
                label.font = Style.TitleH2.font
                label.textColor = Style.TitleH2.textColor
            case .titleB1:
                label.font = Style.TitleB1.font
                label.textColor = Style.TitleB1.textColor
                label.textAlignment = .center
                label.numberOfLines = 1
            case .titleB2:
                label.font = Style.TitleB2.font
                label.textColor = Style.TitleB2.textColor
                label.textAlignment = .left
                label.numberOfLines = 0
            case .titleC3:
                label.font = Style.TitleC3.font
//                label.textColor = Style.TitleC3.textColor
                label.textAlignment = .left
                label.numberOfLines = 1
            case .messageBlack:
                label.font = Style.MessageBlack.font
                label.textColor = Style.MessageBlack.textColor
                label.textAlignment = .left
                label.numberOfLines = 0
            case .messageGray:
                label.font = Style.messageGray.font
                label.textColor = Style.messageGray.textColor
                label.textAlignment = .center
                label.numberOfLines = 0
        }
        return self
    }
}

// MARK: - LabelStyle
enum LabelStyle {
    /// Заполняет font, textColor, textAlignment
    case error
    
    /// Заполняет font, textColor
    case mainRegistration
    /// Заполняет font, textColor
    case infoRegistration
    /// Заполняет font = B2(16reg), textColor(primaryBlack), textAlignment = left, numberOfLines = 0
    case infoBlackB2
    /// Заполняет font = B2(16reg), textColor(secondarySemidarkGrey), textAlignment = left, numberOfLines = 0
    case infoGrayB2
    /// Заполняет font = C3(12reg), textColor(secondarySemidarkGrey), textAlignment = left
    case infoGrayC3
    /// Заполняет font = H2(20semibold), textColor(primaryBlack)
    case titleH2
    /// Заполняет font = B1(16medium), textColor(primaryBlack), textAlignment = center, numberOfLines = 1
    case titleB1
    /// Заполняет font = B2(16reg), textColor(primaryBlack), textAlignment = left, numberOfLines = 0
    case titleB2
    /// Заполняет font = C3(12reg), textColor(-), textAlignment = left, numberOfLines = 1
    // chat cell ?
    case titleC3
    /// Заполняет font = B2(16reg), textColor(primaryBlack), textAlignment = left, numberOfLines = 0
    case messageBlack
    /// Заполняет font = B2(16reg), textColor(secondarySemidarkGrey), textAlignment = center, numberOfLines = 0
    case messageGray
    
}

// MARK: - Style for label
private struct Style {
    struct Error {
        static let font = AppFonts.Caption.C3
        static let colorText = BrandBook.Label.Colors.errorText
    }
    struct MainRegistration {
        static let font = AppFonts.Title.H1
        static let colorText = BrandBook.Label.Colors.blackText
    }
    struct InfoRegistration {
        static let font = AppFonts.Title.H1
        static let colorText = BrandBook.Label.Colors.blackText
    }
    struct InfoBlackB2 {
        static let font = AppFonts.Body.B2
        static let textColor = BrandBook.Label.Colors.blackText
    }
    struct InfoGrayB2 {
        static let font = AppFonts.Body.B2
        static let textColor = BrandBook.Label.Colors.grayText
    }
    struct InfoGrayC3 {
        static let font = AppFonts.Caption.C3
        static let textColor = BrandBook.Label.Colors.grayText
    }
    struct TitleH2 {
        static let font = AppFonts.Title.H2
        static let textColor = BrandBook.Label.Colors.blackText
    }
    struct TitleB1 {
        static let font = AppFonts.Body.B1
        static let textColor = BrandBook.Label.Colors.blackText
    }
    struct TitleB2 {
        static let font = AppFonts.Body.B2
        static let textColor = BrandBook.Label.Colors.blackText
    }
    struct TitleC3 {
        static let font = AppFonts.Caption.C3
    }
    struct MessageBlack {
        static let font = AppFonts.Body.B2
        static let textColor = BrandBook.Label.Colors.blackText
    }
    struct messageGray {
        static let font = AppFonts.Body.B2
        static let textColor = BrandBook.Label.Colors.blackText
    }
}
