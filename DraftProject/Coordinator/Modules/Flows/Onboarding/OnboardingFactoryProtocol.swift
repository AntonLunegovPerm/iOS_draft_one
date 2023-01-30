//
//  OnboardingFactoryProtocol.swift
//
//  Created by LAV on 23.06.2022.
//

import Foundation

protocol OnboardingFactoryProtocol {
    func makeOnboardingView(step: OnboardingStep, onPolitic: CompletionBlock?, onComplete: CompletionBlock?) -> BaseViewProtocol
}
