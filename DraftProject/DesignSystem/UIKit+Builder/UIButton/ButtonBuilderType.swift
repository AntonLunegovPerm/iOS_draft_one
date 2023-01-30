//
//  ButtonBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol ButtonBuilderType: UIViewBuilderType {
    func setTitle(_ title: String) -> Self
    func setFont(_ font: UIFont?) -> Self
    func setTextColor(_ color: UIColor?) -> Self
    func setImage(_ image: UIImage?) -> Self
    func setNumberOfLines(_ number: Int) -> Self
    func setAlignment(_ alignment: NSTextAlignment) -> Self
    
    func addTarget(_ target: Any, action: Selector, for event: UIControl.Event) -> Self
}
