//
//  PageControlBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class PageControlBuilder: PageControlBuilderType {
    
    private var pageControl: UIPageControl
    
    // MARK: - UIBuilderType
    init(_ pageControl: UIPageControl = UIPageControl()) {
        self.pageControl = pageControl
    }
    
    class func startBuild() -> Self {
        PageControlBuilder() as! Self
    }
    
    func build() -> UIPageControl {
        pageControl
    }
    
    // MARK: - PageControlBuilderType
    func useAutoLayout() -> Self {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setCurrentPage(_ page: Int) -> Self {
        pageControl.currentPage = page
        return self
    }
    
    func setNumberOfPages(_ number: Int) -> Self {
        pageControl.numberOfPages = number
        return self
    }
    
    func setCurrentIndicatorTintColor(_ color: UIColor) -> Self {
        pageControl.currentPageIndicatorTintColor = color
        return self
    }
    
    func setIndicatorTintColor(_ color: UIColor) -> Self {
        pageControl.pageIndicatorTintColor = color
        return self
    }
    
    func hidesForSinglePage() -> Self {
        pageControl.hidesForSinglePage = true
        return self
    }
    
    func disableUserInteraction() -> Self {
        pageControl.isUserInteractionEnabled = false
        return self
    }
}
