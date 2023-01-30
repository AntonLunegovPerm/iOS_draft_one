//
//  ButtonBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class ButtonBuilder: ButtonBuilderType {
    
    private var button = UIButton()
    
    init(_ button: UIButton = UIButton()) {
        self.button = button
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        ButtonBuilder() as! Self
    }
    
    func build() -> UIButton {
        return button
    }
    
    // MARK: - UIViewBuilderType
    func useAutoLayout() -> Self {
        button.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> Self {
        button.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        button.clipsToBounds = true
        button.layer.cornerRadius = radius
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        button.layer.borderWidth = width
        button.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - ButtonBuilderType
    func setTitle(_ title: String) -> Self {
        button.setTitle(title, for: .normal)
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        button.titleLabel?.font = font
        return self
    }
    
    func setTextColor(_ color: UIColor?) -> Self {
        button.setTitleColor(color, for: .normal)
        return self
    }
    
    func setImage(_ image: UIImage?) -> Self {
        button.setImage(image, for: .normal)
        return self
    }
    
    func setNumberOfLines(_ number: Int) -> Self {
        button.titleLabel?.numberOfLines = number
        return self
    }
    
    func setAlignment(_ alignment: NSTextAlignment) -> Self {
        button.titleLabel?.textAlignment = alignment
        return self
    }
    
    func addTarget(_ target: Any, action: Selector, for event: UIControl.Event) -> Self {
        button.addTarget(target, action: action, for: event)
        return self
    }
}

// MARK: - StyleBuilder
extension ButtonBuilder: StyleBuilder {
    func setStyle(_ style: ButtonStyle) -> Self {
        switch style {
            case .smallClipsOneLine:
                button.backgroundColor = Style.smallClipsOneLineBackgroundColor
                button.layer.cornerRadius = Style.smallClipsOneLineCornerRadius
                button.clipsToBounds = true
                button.setTitleColor(Style.smallClipsOneLineTextColor, for: .normal)
                button.titleLabel?.font = Style.smallClipsOneLineFont
        }
        return self
    }
}

// MARK: - ButtonStyle
enum ButtonStyle {
    /// Заполняет background, cornerRadius, textColor, font
    case smallClipsOneLine
}

// MARK: - Style for buttons
private struct Style {
    static let smallClipsOneLineBackgroundColor = R.color.mainColor()!
    static let smallClipsOneLineCornerRadius: CGFloat = BrandBook.Button.cornerRadius
    static let smallClipsOneLineTextColor = R.color.mainColor()!
    static let smallClipsOneLineFont = AppFonts.Caption.C3
}
