//
//  ModulesFactory+Main.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation

// MARK: AuthorizationFactoryProtocol
extension ModulesFactory: MainFactoryProtocol {
    
    func makeMainPageView(onAction1: CompletionBlock?, onAction2: CompletionBlock?) -> BaseViewProtocol {
        let view = MainViewController()
        let viewModel = MainViewModel()
        
        view.viewModel = viewModel
        view.onAction1 = onAction1
        view.onAction2 = onAction2
        
        return view
    }
    
}
