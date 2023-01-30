//
//  CustomPageControl.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

final class CustomPageControl: UIPageControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        pageIndicatorTintColor = Style.indicatorTint
        currentPageIndicatorTintColor = Style.currentIndicatorTint
        isUserInteractionEnabled = false
    }
}

private struct Style {
    static let currentIndicatorTint = BrandBook.PageControl.Colors.currentIndicatorTint
    static let indicatorTint = BrandBook.PageControl.Colors.indicatorTint
}
