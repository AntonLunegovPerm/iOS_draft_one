//
//  StackViewBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol StackViewBuilderType: UIViewBuilderType {
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> Self
    func setDistribution(_ distribution: UIStackView.Distribution) -> Self
    func setAlignment(_ alignment: UIStackView.Alignment) -> Self
    func setSpacing(_ spacing: CGFloat) -> Self
    func setCustomSpacing(_ spacing: CGFloat, after view: UIView) -> Self
    func setSemanticContent(_ attribute: UISemanticContentAttribute) -> Self
    
    func addArrangedSubviews(_ views: UIView...) -> Self
    func addArrangedSubviews(_ views: [UIView]) -> Self
}
