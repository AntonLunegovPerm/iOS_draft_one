//
//  APIResponseParser.swift
//  DraftProject
//
//  Created by LAV on 31.01.2023.
//

import Foundation

private let kAPI_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

struct APIResponseParser<In, Out> {
    static func parseJSON(_ data: In) -> Out? where In == Data, Out: Decodable {
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = kAPI_DATE_FORMAT
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            return try jsonDecoder.decode(Out.self, from: data)
        } catch {
            #if DEBUG
            let log = """

            💥 Response error: \(error.localizedDescription) \(error)
            
            """
            print(log)
            #endif
            return nil
        }
    }
    
    static func passthrough(_ value: In) -> In {
        value
    }
}

