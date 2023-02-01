//
//  Resource.swift
//  DraftProject
//
//  Created by LAV on 31.01.2023.
//

import Foundation
import Alamofire

private let kAPI_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

struct Resource<RequestBodyType: Encodable, ResponseType, ParsedResponseType> {
    var url: URL
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var body: RequestBodyType? = nil
    var bodyEncoder: ParameterEncoder = JSONParameterEncoder.defaultEncoderWith(dateFormat: kAPI_DATE_FORMAT)
    var parse: (ResponseType) -> ParsedResponseType?
}

extension Resource where RequestBodyType == Empty {
    init(url: URL, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, parse: @escaping (ResponseType) -> ParsedResponseType?) {
        self.init(url: url, method: method, headers: headers, body: nil, parse: parse)
    }
}

