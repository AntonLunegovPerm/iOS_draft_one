//
//  CustomIconImageView.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit
import SnapKit

final class CustomIconImageView: UIView {
    
    // MARK: - Private UI
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupImageView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        snp.makeConstraints { make in
            make.size.equalTo(Style.size)
        }
    }
    
    private func setupImageView() {
        imageView = ImageViewBuilder.startBuild()
            .setContentMode(.scaleAspectFit)
            .build()
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(Style.size)
        }
    }
    
    // MARK: - Public methods
    func setImage(_ image: Image) {
        imageView.image = image.image
    }
    
    func setColorImage(_ color: UIColor) {
        imageView.image = imageView.image?.image(tintColor: color)
    }
}

extension CustomIconImageView {
    enum Image {
        case searchImage
        
        var image: UIImage {
            switch self {
            case .searchImage: return R.image.groupIcon()!
            }
        }
    }
}

private struct Style {
    static let size: CGFloat = BrandBook.Icon.Size.small
}
