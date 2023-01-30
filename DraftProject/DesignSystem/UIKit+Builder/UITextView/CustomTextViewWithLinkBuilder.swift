//
//  CustomTextViewWithLinkBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class CustomTextViewWithLinkBuilder: TextViewBuilder {
    
    private var textView: CustomTextViewWithLink
    
    init(_ textView: CustomTextViewWithLink = CustomTextViewWithLink()) {
        self.textView = textView
        super.init(textView)
    }
    
    override class func startBuild() -> Self {
        CustomTextViewWithLinkBuilder() as! Self
    }
    
    override func build() -> CustomTextViewWithLink {
        textView
    }
}
