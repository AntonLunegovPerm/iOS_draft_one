//
//  TextViewBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol TextViewBuilderType: UIViewBuilderType {
    func setText(_ text: String) -> Self
    func setFont(_ font: UIFont?) -> Self
    func setTextColor(_ color: UIColor) -> Self
    func setTintColor(_ color: UIColor) -> Self
    func setIsSelectable(_ isSelectable: Bool) -> Self
    func setIsEditable(_ isEditable: Bool) -> Self
    func setIsScrollEnabled(_ isScrollEnabled: Bool) -> Self
    
    func setKeyboardType(_ type: UIKeyboardType) -> Self
    func setReturnKeyType(_ type: UIReturnKeyType) -> Self
    func setAutocapitalizationType(_ type: UITextAutocapitalizationType) -> Self
    func setDelegate(_ delegate: UITextViewDelegate) -> Self
}
