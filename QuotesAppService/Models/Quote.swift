//
//  Models.swift
//  QuotesAppService
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import Foundation

public struct Quote: Codable, Hashable {
    
    public let quote: String
    public var category: String

    public init() {
        quote = ""
        category = ""
    }

    public init(quote: String, category: String) {
        self.quote = quote
        self.category = category
    }

    public func getEncodedString() -> String? {
        guard let data = try? JSONEncoder().encode(self),
              let json = String(data: data, encoding: .utf8) else {
            return nil
        }

        return json.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }

    public static func quote(from encoded: String) -> Quote? {
        guard let decoded = encoded.removingPercentEncoding else {
            return nil
        }

        guard let data = decoded.data(using: .utf8), let quote = try? JSONDecoder().decode(Quote.self, from: data) else {
            return nil
        }

        return quote
    }
}
