//
//  ExamplePresenter.swift
//  DraftProject
//
//  Created by Антон Лунегов on 29.01.2023.
//
import UIKit

final class ExamplePresenter: ExampleInteractorOutput, ExampleViewOutput {
    
    // MARK: - Properties
    
    let router:     ExampleRouterProtocol
    let interactor: ExampleInteractorInput
    weak var view:  ExampleViewInput?
    
    // MARK: - Private properties
    
    
    // MARK: - Init
    
    init(router: ExampleRouterProtocol, interactor: ExampleInteractorInput) {
        self.router     = router
        self.interactor = interactor
    }
    
    // MARK: - ExampleViewOutput
    
    func viewDidLoad() {
        
    }
    
    // MARK: - ExampleInteractorOutput
    
    func showUnauthorizedAlert(){
        
    }
    
    func showTopAlertView(text: String){
        
    }
    
    func showProgressView(){
        
    }
    
    func hideProgressView(){
        
    }
}
