//
//  Data+Parse.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

extension Data {
    func parse<T: Decodable>(asObject model: T.Type, usingKeyDecodingStrategy strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = strategy
            decoder.dateDecodingStrategy = .custom({ decoder -> Date in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withFullDate,
                                           .withTime,
                                           .withDashSeparatorInDate,
                                           .withColonSeparatorInTime]
                return formatter.date(from: dateStr) ?? Date()

            })
            let resp = try decoder.decode(T.self, from: self)
            return resp
        } catch {
            print("Error: \(#function) - \(error)")
            return nil
        }
    }
}
