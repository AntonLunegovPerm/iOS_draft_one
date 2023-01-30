//
//  CustomTextField.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

enum CustomTextFielddState {
    case error
    case placeholder
    case text
}

class CustomTextField: UITextField {
    public var stateTextField: CustomTextFielddState = .text {
        didSet {
            setState(stateTextField)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        borderStyle = .none
        layer.masksToBounds = true
        tintColor = Style.tintColor
        layer.cornerRadius = Style.cornerRadius
        backgroundColor = Style.backgroundColor
        font = Style.font
        textColor = Style.textColor
    }
    
    private func setState(_ state: CustomTextFielddState) {
        switch state {
            case .error:
                textColor = Style.errorTextColor
            case .placeholder:
                textColor = Style.placeholderColor
                attributedPlaceholder = NSAttributedString(
                    string: placeholder ?? "",
                    attributes: [NSAttributedString.Key.foregroundColor: Style.placeholderColor,
                                 NSAttributedString.Key.font: Style.font]
                )
            case .text:
                textColor = Style.textColor
        }
    }
}

private struct Style {
    static let textColor = BrandBook.TextField.Colors.text
    static let errorTextColor = BrandBook.TextField.Colors.error
    static let placeholderColor = BrandBook.TextField.Colors.placeholder
    static let font = BrandBook.TextField.font
    static let tintColor = BrandBook.TextField.Colors.tint
    static let cornerRadius: CGFloat = BrandBook.TextField.cornerRadius
    static let backgroundColor = BrandBook.TextField.Colors.background
}
