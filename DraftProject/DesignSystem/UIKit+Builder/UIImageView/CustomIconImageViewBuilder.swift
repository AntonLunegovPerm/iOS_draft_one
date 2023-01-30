//
//  CustomIconImageViewBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol CustomIconImageViewBuilderType: UIBuilderType {
    func setImage(_ image: CustomIconImageView.Image) -> Self
    func setTintColor(_ color: UIColor) -> Self
}

final class CustomIconImageViewBuilder: CustomIconImageViewBuilderType {
    private var imageView: CustomIconImageView
    
    // MARK: - UIBuilderType
    init(_ imageView: CustomIconImageView = CustomIconImageView()) {
        self.imageView = imageView
    }
    
    class func startBuild() -> Self {
        CustomIconImageViewBuilder() as! Self
    }
    
    func build() -> CustomIconImageView {
        imageView
    }
    
    // MARK: - CustomIconImageViewBuilderType
    func setImage(_ image: CustomIconImageView.Image) -> Self {
        imageView.setImage(image)
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        imageView.setColorImage(color)
        return self
    }
}
