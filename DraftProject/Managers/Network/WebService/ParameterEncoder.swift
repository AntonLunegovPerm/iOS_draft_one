//
//  ParameterEncoder.swift
//  DraftProject
//
//  Created by LAV on 31.01.2023.
//

import Foundation
import Alamofire

extension URLEncodedFormParameterEncoder {
    static func defaultEncoderWith(dateFormat: String) -> URLEncodedFormParameterEncoder {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        let encoder = URLEncodedFormEncoder(dateEncoding: .formatted(dateFormatter))
        return URLEncodedFormParameterEncoder(encoder: encoder)
    }
}

extension JSONParameterEncoder {
    static func defaultEncoderWith(dateFormat: String) -> JSONParameterEncoder {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return JSONParameterEncoder(encoder: encoder)
    }
}
