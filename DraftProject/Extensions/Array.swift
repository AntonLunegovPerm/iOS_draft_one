//
//  Array.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import Foundation

extension Array {
    
    func value(index: Index) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    @inlinable public func compactFirst<ElementOfResult>(where predicate: (Element) throws -> ElementOfResult?) rethrows -> ElementOfResult? {
        for element in self {
            if let result = try predicate(element) {
                return result
            }
        }
        return nil
    }
}
