//
//  AuthorizationFactoryProtocol.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation

protocol AuthorizationFactoryProtocol {
    func makeEnterView(onComplete: CompletionBlock?, onPolitic: CompletionBlock?, onTermsUse: CompletionBlock?) -> BaseViewProtocol
}

protocol AboutAppProtocol {
    func makeUserAgreement() -> BaseViewProtocol
    func makePolitics() -> BaseViewProtocol
}
