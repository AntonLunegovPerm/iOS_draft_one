//
//  ExampleInteractor.swift
//  DraftProject
//
//  Created by Антон Лунегов on 29.01.2023.
//

import Foundation

// MARK: - Protocols

protocol ExampleInteractorInput: AnyObject {
    func exampleRequest()
}

protocol ExampleInteractorOutput: PresenterProtocol {
    func showUnauthorizedAlert()
    func showTopAlertView(text: String)
    func showProgressView()
    func hideProgressView()
}

final class ExampleInteractor: InteractorProtocol, ExampleInteractorInput {

    
    // MARK: - Public Properties
    
    weak var presenter: ExampleInteractorOutput?
    
    // MARK: - Private properties
    
    
    // MARK: - Init
    
    init() {
        
    }
    
    // MARK: - ExampleInteractorInput
    
    func exampleRequest() {
        
    }
}
