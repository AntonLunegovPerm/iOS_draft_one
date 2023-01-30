//
//  TextFieldBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class TextFieldBuilder: TextFieldBuilderType {
    
    private var textField: UITextField
    
    init(_ textField: UITextField = UITextField()) {
        self.textField = textField
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        TextFieldBuilder() as! Self
    }
    
    func build() -> UITextField {
        textField
    }
    
    // MARK: - UIViewBuilderType
    func useAutoLayout() -> Self {
        textField.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func setBackgroundColor(_ color: UIColor?) -> Self {
        textField.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        textField.clipsToBounds = true
        textField.layer.cornerRadius = radius
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        textField.layer.borderWidth = width
        textField.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - TextFieldBuilderType
    func setText(_ text: String) -> Self {
        textField.text = text
        return self
    }
    
    func setPlaceholder(_ placeholder: String) -> Self {
        textField.placeholder = placeholder
        return self
    }
    
    func setBorderStyle(_ style: UITextField.BorderStyle) -> Self {
        textField.borderStyle = style
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        textField.font = font
        return self
    }
    
    func setTextColor(_ color: UIColor) -> Self {
        textField.textColor = color
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        textField.tintColor = color
        return self
    }
    
    func setKeyboardType(_ type: UIKeyboardType) -> Self {
        textField.keyboardType = type
        return self
    }

    func setReturnKeyType(_ type: UIReturnKeyType) -> Self {
        textField.returnKeyType = type
        return self
    }
    
    func setAutocapitalizationType(_ type: UITextAutocapitalizationType) -> Self {
        textField.autocapitalizationType = type
        return self
    }
    
    func setLeftView(_ view: UIView, mode: UITextField.ViewMode) -> Self {
        textField.leftView = view
        textField.leftViewMode = mode
        return self
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate) -> Self {
        textField.delegate = delegate
        return self
    }
    
    func disableUserInteraction() -> Self {
        textField.isUserInteractionEnabled = false
        return self
    }
}
