//
//  NetworkManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import Moya

enum ServerAPI {
    case signin(login: String, password: String)
    case document(id: String)
    case profile
}

extension ServerAPI: TargetType {
    
    @Inject static private var settings: SettingsProtocol?
    
    static let baseUrl = "http://www.url.ru/"
    
    public var baseURL: URL {
        return URL(string: ServerAPI.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .signin:
            return "signin"
        case .document:
            return "document"
        case .profile:
            return "profile"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signin, .document:
            return .post
        case .profile:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .signin(let login, let password):
            return  .requestParameters(parameters: ["login" : login, "password": password], encoding: JSONEncoding.default)
        case .document(let id):
            return .requestParameters(parameters: ["id" : id], encoding: JSONEncoding.default)
        case .profile:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        let userName: String = ServerAPI.settings?.auth.userName ?? ""
        
        let uidTokenDic = [
            "userName": userName
        ]
        
        switch self {
        case .signin(login: _, password: _):
            return ["Content-type": "application/json"]
        default:
            return uidTokenDic
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    private func requestParams(params: [String: Any]) -> Task {
        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
