//
//  ViewBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class ViewBuilder: ViewBuilderType {

    private var view: UIView
    
    init(_ view: UIView = UIView()) {
        self.view = view
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        ViewBuilder() as! Self
    }
    
    func build() -> UIView {
        view
    }
    
    // MARK: - UIViewBuilderType
    func useAutoLayout() -> Self {
        view.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> Self {
        view.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - ViewBuilderType
    func addSubviews(_ views: UIView...) -> Self {
        views.forEach { view.addSubview($0) }
        return self
    }
}

// MARK: - StyleBuilder
extension ViewBuilder: StyleBuilder {
    func setStyle(_ style: ViewStyle) -> Self {
        switch style {
            
        }
        return self
    }
}

// MARK: - ViewStyle
enum ViewStyle {

}

// MARK: - Style for view
private struct Style {

}

