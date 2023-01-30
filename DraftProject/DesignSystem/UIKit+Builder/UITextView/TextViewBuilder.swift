//
//  TextViewBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class TextViewBuilder: TextViewBuilderType {
    
    private var textView = UITextView()
    
    init(_ textView: UITextView = UITextView()) {
        self.textView = textView
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        TextViewBuilder() as! Self
    }
    
    func build() -> UITextView {
        textView
    }
    
    // MARK: - UIViewBuilderType
    func useAutoLayout() -> Self {
        textView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func setBackgroundColor(_ color: UIColor?) -> Self {
        textView.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        textView.clipsToBounds = true
        textView.layer.cornerRadius = radius
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        textView.layer.borderWidth = width
        textView.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - TextViewBuilderType
    func setText(_ text: String) -> Self {
        textView.text = text
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        textView.font = font
        return self
    }
    
    func setTextColor(_ color: UIColor) -> Self {
        textView.textColor = color
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        textView.tintColor = color
        return self
    }
    
    func setIsSelectable(_ isSelectable: Bool) -> Self {
        textView.isSelectable = isSelectable
        return self
    }
    
    func setIsEditable(_ isEditable: Bool) -> Self {
        textView.isEditable = isEditable
        return self
    }
    
    func setIsScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        textView.isScrollEnabled = isScrollEnabled
        return self
    }
    
    func setKeyboardType(_ type: UIKeyboardType) -> Self {
        textView.keyboardType = type
        return self
    }
    
    func setReturnKeyType(_ type: UIReturnKeyType) -> Self {
        textView.returnKeyType = type
        return self
    }
    
    func setAutocapitalizationType(_ type: UITextAutocapitalizationType) -> Self {
        textView.autocapitalizationType = type
        return self
    }

    func setDelegate(_ delegate: UITextViewDelegate) -> Self {
        textView.delegate = delegate
        return self
    }
}
