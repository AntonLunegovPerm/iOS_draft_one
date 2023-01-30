//
//  PageControlBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol PageControlBuilderType: UIBuilderType {
    func useAutoLayout() -> Self
    func setCurrentPage(_ page: Int) -> Self
    func setNumberOfPages(_ number: Int) -> Self
    func setCurrentIndicatorTintColor(_ color: UIColor) -> Self
    func setIndicatorTintColor(_ color: UIColor) -> Self
    func hidesForSinglePage() -> Self
    func disableUserInteraction() -> Self
}
