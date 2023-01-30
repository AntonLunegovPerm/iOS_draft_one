//
//  TextFieldBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol TextFieldBuilderType: UIViewBuilderType {
    func setText(_ text: String) -> Self
    func setPlaceholder(_ placeholder: String) -> Self
    func setBorderStyle(_ style: UITextField.BorderStyle) -> Self
    func setFont(_ font: UIFont?) -> Self
    func setTextColor(_ color: UIColor) -> Self
    func setTintColor(_ color: UIColor) -> Self
    func setKeyboardType(_ type: UIKeyboardType) -> Self
    func setReturnKeyType(_ type: UIReturnKeyType) -> Self
    func setAutocapitalizationType(_ type: UITextAutocapitalizationType) -> Self
    func setLeftView(_ view: UIView, mode: UITextField.ViewMode) -> Self
    func setDelegate(_ delegate: UITextFieldDelegate) -> Self
    
    func disableUserInteraction() -> Self
}
