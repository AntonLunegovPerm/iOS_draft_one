//
//  MainFactoryProtocol.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation

protocol MainFactoryProtocol {
    func makeMainPageView(onAction1: CompletionBlock?, onAction2: CompletionBlock?) -> BaseViewProtocol
}
