//
//  CustomIconButtonBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol CustomIconButtonBuilderType: UIBuilderType {
    func setImage(_ image: CustomIconButton.SizeButtonType) -> Self
    func setTintColor(_ color: UIColor) -> Self
    func setAction(_ action: CompletionBlock?) -> Self
}

class CustomIconButtonBuilder: CustomIconButtonBuilderType {
    
    private var button: CustomIconButton
    
    // MARK: - UIBuilderType
    init(_ button: CustomIconButton = CustomIconButton()) {
        self.button = button
    }
    
    class func startBuild() -> Self {
        CustomIconButtonBuilder() as! Self
    }
    
    func build() -> CustomIconButton {
        button
    }
    
    // MARK: - CustomIconButtonBuilderType
    func setImage(_ image: CustomIconButton.SizeButtonType) -> Self {
        button.setImage(image)
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        button.setColorImage(color)
        return self
    }
    
    func setAction(_ action: CompletionBlock?) -> Self {
        button.action = action
        return self
    }
}
