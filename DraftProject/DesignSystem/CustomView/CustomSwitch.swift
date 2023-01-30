//
//  CustomSwitch.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

final class CustomSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSwitch() {
        onTintColor = StyleSwitch.tintColor
    }
}

private struct StyleSwitch {
    static let tintColor = BrandBook.Switch.Colors.onTint
}
