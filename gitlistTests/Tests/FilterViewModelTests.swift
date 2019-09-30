//
//  FilterViewModelTests.swift
//  gitlistTests
//
//  Created by Paulo Lourenço on 29/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import XCTest
@testable import gitlist

class FilterViewModelTests: XCTestCase {
    
    func testInit() {
        let filter = Filter(order: .asc, sort: .updated)
        let sut = FilterViewModel(filter: filter)
        XCTAssertEqual(sut.filter?.order, .asc)
        XCTAssertEqual(sut.filter?.sort, .updated)
    }
    
}
