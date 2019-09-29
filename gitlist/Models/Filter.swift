//
//  Filter.swift
//  gitlist
//
//  Created by Paulo Lourenço on 29/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

enum Order: String, CaseIterable {
    case asc, desc
}

enum Sort: String, CaseIterable {
    case stars, forks, updated
}

struct Filter {
    var order: Order
    var sort: Sort
}
