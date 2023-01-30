//
//  CustomTextViewWithLink.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

final class CustomTextViewWithLink: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextView() {
        isScrollEnabled = false
        isSelectable = true
        isEditable = false
        textAlignment = .left
        dataDetectorTypes = .link
        linkTextAttributes = [
            .foregroundColor: Style.linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.clear,
        ]
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0.0
        backgroundColor = Style.backgroundColor
        textColor = Style.textColor
        font = Style.font
    }
}

private struct Style {
    static let linkColor = BrandBook.TextView.Colors.linkColor
    static let textColor = BrandBook.TextView.Colors.textColor
    static let font = BrandBook.TextView.font
    static let backgroundColor = UIColor.clear
    static let grayTextColor = BrandBook.TextView.Colors.grayTextColor
}

extension CustomTextViewWithLink {
    enum AppearanceText {
        case black
        case gray
        case link
    }
    
    func createMutableAttributedString(_ text: String, url: URL? = nil, appearance: AppearanceText) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: text)
        switch appearance {
            case .black:
                attributedText.addAttribute(.foregroundColor, value: Style.textColor, range: range)
            case .gray:
                attributedText.addAttribute(.foregroundColor, value: Style.grayTextColor, range: range)
            case .link:
                attributedText.addAttribute(.foregroundColor, value: Style.linkColor, range: range)
                if let url {
                    attributedText.addAttribute(.link, value: url, range: range)
                }
        }
        attributedText.addAttribute(.font, value: Style.font, range: range)
        return attributedText
    }
}
