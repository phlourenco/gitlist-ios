//
//  BaseResults.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

struct SearchResults<T: Codable>: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: T
}
