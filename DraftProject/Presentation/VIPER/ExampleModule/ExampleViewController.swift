//
//  ExampleViewController.swift
//  DraftProject
//
//  Created by Антон Лунегов on 29.01.2023.
//

import UIKit

// MARK: - Protocols

protocol ExampleViewOutput: AnyObject {
    func viewDidLoad()
}

protocol ExampleViewInput: AnyObject {
//    func getTableView() -> UITableView
    func showProgressView()
    func hideProgressView()
    func endRefreshing()
}

final class ExampleViewController:  UIViewController, ViewProtocol, ExampleViewInput {
    
    // MARK: - Properties
    
    private let presenter: ExampleViewOutput

    // MARK: - Inits
    
    init(presenter: ExampleViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ExampleViewInput
    
//    func getTableView() -> UITableView {
//        return tableView
//    }
    
    func showProgressView() {
   
    }
    
    func hideProgressView() {

    }
    
    func endRefreshing() {

    }
}
    
