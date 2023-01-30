//
//  AuthViewModel.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AuthViewModelInputs {
    var smsCode: BehaviorRelay<String> { get }
    func resendSMSCode()
    func verifySMSCode()
}

protocol AuthViewModelOutputs {
    var isLoading: BehaviorRelay<Bool> { get }
    var error: PublishRelay<Error> { get }
}

protocol AuthViewModelType {
    var inputs: AuthViewModelInputs { get }
    var outputs: AuthViewModelOutputs { get }
}

class AuthViewModel: AuthViewModelType, AuthViewModelInputs, AuthViewModelOutputs {
    
    func resendSMSCode() {}
    
    func verifySMSCode() {}
    
    var inputs: AuthViewModelInputs { self }
    var outputs: AuthViewModelOutputs { self }
    
    // MARK: Outputs
    var smsCode = BehaviorRelay<String>(value: "")
    let isLoading = BehaviorRelay(value: false)
    let error = PublishRelay<Error>()
    
}
