//
//  CustomIconButton.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

final class CustomIconButton: UIView {
    // MARK: - Public properties
    public var action: (() -> Void)?
    
    // MARK: - private UI
    private var imageView: UIImageView!
    
    // MARK: - Private properties
    private var type: SizeButtonType?
    private var size: CGFloat = 0.0 {
        didSet {
            snp.updateConstraints { make in
                make.size.equalTo(size)
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        setupView()
        setupImageView()
    }
    
    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        addGestureRecognizer(tap)
        backgroundColor = .clear
        
        snp.makeConstraints { make in
            make.size.equalTo(size)
        }
    }
    
    private func setupImageView() {
        imageView = ImageViewBuilder.startBuild()
            .setContentMode(.scaleAspectFit)
            .build()
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(Style.imageSize)
        }
    }
    
    // MARK: - Public methods
    func setImage(_ type: SizeButtonType) {
        switch type {
            case .small(let image):
                imageView.image = image.image
                backgroundColor = Style.Small.backgroundColor
                size = Style.Small.size
                layer.cornerRadius = Style.Small.cornerRadius
            case .medium(let image):
                imageView.image = image.image
                backgroundColor = Style.Medium.backgroundColor
                size = Style.Medium.size
                layer.cornerRadius = Style.Medium.cornerRadius
                clipsToBounds = true
        }
    }
    
    func setColorImage(_ color: UIColor) {
        imageView.image = imageView.image?.image(tintColor: color)
    }
    
    @objc private func tapPressed() {
        action?()
    }
}

extension CustomIconButton {
    enum SizeButtonType {
        case small(image: SmallButtonImage)
        case medium(image: MediumButtonImage)
    }
    
    enum SmallButtonImage {
        case edit
        case priceChecker
        // add name image
        
        var image: UIImage {
            switch self {
                case .edit:
                return R.image.groupIcon()!
                case .priceChecker:
                    return R.image.groupIcon()!
                
            }
        }
    }
    
    enum MediumButtonImage {
        
        // add name image
        
        var image: UIImage {
            switch self {
                    
                // return image from asset
                    
            }
        }
    }
}

private struct Style {
    static let imageSize: CGFloat = BrandBook.Icon.Size.small
    
    struct Small {
        static let size: CGFloat = BrandBook.Icon.Size.small
        static let backgroundColor = BrandBook.Icon.Colors.smallBackground
        static let cornerRadius: CGFloat = 0.0
    }
    
    struct Medium {
        static let size: CGFloat = BrandBook.Icon.Size.medium
        static let backgroundColor = BrandBook.Icon.Colors.mediumBackground
        static let cornerRadius: CGFloat = BrandBook.Button.cornerRadius
    }
}

