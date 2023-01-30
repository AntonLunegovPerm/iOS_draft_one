//
//  ImageViewBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol ImageViewBuilderType: UIViewBuilderType {
    func setContentMode(_ contentMode: UIImageView.ContentMode) -> Self
    func setImage(_ image: String) -> Self
    func setImage(_ image: UIImage?) -> Self
    func setTintColor(_ color: UIColor) -> Self
    func roundCorners(_ corners: UIRectCorner, _ radius: CGFloat) -> Self
    func activateUserInteraction() -> Self
    func setMaskedCorners(_ maskedCorners: CACornerMask) -> Self
}
