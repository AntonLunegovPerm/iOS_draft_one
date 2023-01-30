//
//  CustomPageBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

final class CustomPageBuilder: PageControlBuilder {
    
    private var pageControl: CustomPageControl

    // MARK: - UIBuilderType
    init(_ pageControl: CustomPageControl = CustomPageControl()) {
        self.pageControl = pageControl
        super.init(pageControl)
    }

    override class func startBuild() -> Self {
        CustomPageBuilder() as! Self
    }
    
    override func build() -> UIPageControl {
        pageControl
    }
}
