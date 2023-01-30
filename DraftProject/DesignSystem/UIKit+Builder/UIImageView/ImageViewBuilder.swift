//
//  ImageViewBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class ImageViewBuilder: UIViewBuilderType {

    private var imageView: UIImageView
    
    init(_ imageView: UIImageView = UIImageView()) {
        self.imageView = imageView
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        ImageViewBuilder() as! Self
    }
    
    func build() -> UIImageView {
        imageView
    }
    
    // MARK: - UIViewBuilder
    func useAutoLayout() -> Self {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> Self {
        imageView.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = radius
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - ImageViewBuilderType
    func setContentMode(_ contentMode: UIView.ContentMode) -> Self {
        imageView.contentMode = contentMode
        return self
    }
    
    func setImage(_ image: String) -> Self {
        imageView.image = UIImage(named: image)
        return self
    }
    
    func setImage(_ image: UIImage?) -> Self {
        imageView.image = image
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        imageView.image = imageView.image?.withTintColor(color, renderingMode: .alwaysOriginal)
        return self
    }

    func roundCorners(_ corners: UIRectCorner, _ radius: CGFloat) -> Self {
        imageView.roundCorners(corners: corners, radius: radius)
        return self
    }
    
    func activateUserInteraction() -> Self {
        imageView.isUserInteractionEnabled = true
        return self
    }
    
    func setMaskedCorners(_ maskedCorners: CACornerMask) -> Self {
        imageView.layer.maskedCorners = maskedCorners
        return self
    }
}

extension ImageViewBuilder: StyleBuilder {
    func setStyle(_ style: ImageViewStyle) -> Self {
        switch style {
                
        }
        return self
    }
}

enum ImageViewStyle {
    
}

private struct Style {
    
}
