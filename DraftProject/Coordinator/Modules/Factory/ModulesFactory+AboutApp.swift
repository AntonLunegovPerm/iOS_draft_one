//
//  ModulesFactory+AboutApp.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit

extension ModulesFactory: AboutAppProtocol {
    
    func makeUserAgreement() -> BaseViewProtocol {
        let vc = ViewController.instanceView()
        vc.view.backgroundColor = .red
        
        return vc
    }
    
    func makePolitics() -> BaseViewProtocol {
        let vc = ViewController.instanceView()
        vc.view.backgroundColor = .green
        
        return vc
    }
    
}
