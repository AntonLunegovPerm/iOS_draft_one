//
//  LabelBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol LabelBuilderType: UIViewBuilderType {
    func setFont(_ font: UIFont) -> Self
    func setTextColor(_ color: UIColor) -> Self
    func setText(_ text: String) -> Self
    func setNumberOfLines(_ number: Int) -> Self
    func setAlignment(_ alignment: NSTextAlignment) -> Self
}
