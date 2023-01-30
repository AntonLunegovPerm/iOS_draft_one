//
//  ModulesFactory+Onboarding.swift
//  DraftProject
//
//  Created by LAV on 28.01.2023.
//

import Foundation

extension ModulesFactory: OnboardingFactoryProtocol {
    func makeOnboardingView(step: OnboardingStep, onPolitic: CompletionBlock?, onComplete: CompletionBlock?) -> BaseViewProtocol {
        let view = OnboardingViewController()
//        view.step = step
//        view.onContinue = onComplete
//        view.onPolitic = onPolitic
        
        return view
    }
}

enum OnboardingStep: Int {
    case step1 = 1
    case step2 = 2
    case step3 = 3
}
