//
//  ViewModel.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import Moya

class ViewModel {
    let provider = MoyaProvider<ServerAPI>(plugins: [NetworkLoggerPlugin()])
}
