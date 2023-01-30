//
//  UIBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol UIBuilderType where View: UIView {
    associatedtype View
    
    static func startBuild() -> Self
    func build() -> View
}

protocol UIViewBuilderType: UIBuilderType {
    func useAutoLayout() -> Self
    func setBackgroundColor(_ color: UIColor?) -> Self
    func setCornerRadius(_ radius: CGFloat) -> Self
    func setBorder(width: CGFloat, color: UIColor) -> Self
}

protocol StyleBuilder {
    associatedtype StyleType
    
    func setStyle(_ style: StyleType) -> Self
}
