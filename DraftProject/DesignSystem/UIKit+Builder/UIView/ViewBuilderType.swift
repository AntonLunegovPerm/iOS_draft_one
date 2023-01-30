//
//  ViewBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//
import UIKit

protocol ViewBuilderType: UIViewBuilderType {
    func addSubviews(_ views: UIView...) -> Self
}
