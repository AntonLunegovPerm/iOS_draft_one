//
//  ModulesFactory+Auth.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation

// MARK: AuthorizationFactoryProtocol
extension ModulesFactory: AuthorizationFactoryProtocol {
    
    func makeEnterView(onComplete: CompletionBlock?, onPolitic: CompletionBlock?, onTermsUse: CompletionBlock?) -> BaseViewProtocol {
        let view = AuthViewController.instanceView()
        let viewModel = AuthViewModel()
        
        view.viewModel = viewModel
        view.onPolitic = onPolitic
        view.onTermsUse = onTermsUse
        
        return view
    }
    
}
