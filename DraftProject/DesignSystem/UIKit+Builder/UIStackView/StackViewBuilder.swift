//
//  StackViewBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class StackViewBuilder: StackViewBuilderType {
    private var stackView = UIStackView()
    
    init(_ stackView: UIStackView = UIStackView()) {
        self.stackView = stackView
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        StackViewBuilder() as! Self
    }
    
    func build() -> UIStackView {
        stackView
    }

    // MARK: - UIViewBuilderType
    func useAutoLayout() -> Self {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> Self {
        stackView.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        stackView.layer.cornerRadius = radius
        stackView.clipsToBounds = true
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        stackView.layer.borderWidth = width
        stackView.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - StackViewBuilder
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> Self {
        stackView.axis = axis
        return self
    }
    
    func setDistribution(_ distribution: UIStackView.Distribution) -> Self {
        stackView.distribution = distribution
        return self
    }
    
    func setAlignment(_ alignment: UIStackView.Alignment) -> Self {
        stackView.alignment = alignment
        return self
    }
    
    func setSpacing(_ spacing: CGFloat) -> Self {
        stackView.spacing = spacing
        return self
    }
    
    func setCustomSpacing(_ spacing: CGFloat, after view: UIView) -> Self {
        stackView.setCustomSpacing(spacing, after: view)
        return self
    }
    
    func setSemanticContent(_ attribute: UISemanticContentAttribute) -> Self {
        stackView.semanticContentAttribute = attribute
        return self
    }
    
    func addArrangedSubviews(_ views: UIView...) -> Self {
        for view in views { stackView.addArrangedSubview(view) }
        return self
    }
    
    func addArrangedSubviews(_ views: [UIView]) -> Self {
        for view in views { stackView.addArrangedSubview(view) }
        return self
    }
}
