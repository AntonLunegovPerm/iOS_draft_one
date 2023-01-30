//
//  ExampleModule.swift
//  DraftProject
//
//  Created by Антон Лунегов on 29.01.2023.
//

import UIKit

final class ExampleModule: ModuleProtocol {

    // MARK: - Properties
    
    private(set) lazy var interactor: ExampleInteractor = {
        ExampleInteractor()
    }()

    private(set) lazy var router: ExampleRouter = {
        ExampleRouter()
    }()

    private(set) lazy var presenter: ExamplePresenter = {
        ExamplePresenter(router: router, interactor: interactor)
    }()

    private(set) lazy var view: ExampleViewController = {
        ExampleViewController(presenter: presenter)
    }()

    var viewController: UIViewController {
        return view
    }

    // MARK: - Init
    
    init() {
        presenter.view = view
        router.viewController = view
        interactor.presenter = presenter
    }
}

