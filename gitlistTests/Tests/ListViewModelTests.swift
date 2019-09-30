//
//  ListViewModelTests.swift
//  gitlistTests
//
//  Created by Paulo Lourenço on 29/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import XCTest
@testable import gitlist
import RxTest

class ListViewModelTests: XCTestCase {
    
    func testError() {
        let listViewMock = ListViewMock()
        let apiMock = GithubAPIMock()
        apiMock.error = true
        let sut = ListViewModel(view: listViewMock, dataSource: apiMock)
        sut.fetchRepositories(next: false)
        XCTAssertTrue(listViewMock.calledShowError)
        XCTAssertEqual(listViewMock.calledShowErrorCount, 1)
    }
    
    func testErrorTryAgain() {
        let listViewMock = ListViewMock()
        listViewMock.tryAgain = true
        let apiMock = GithubAPIMock()
        apiMock.error = true
        let sut = ListViewModel(view: listViewMock, dataSource: apiMock)
        sut.fetchRepositories(next: false)
        XCTAssertTrue(listViewMock.calledShowError)
        XCTAssertEqual(listViewMock.calledShowErrorCount, 2)
    }
    
    func testSuccess() {
        let listViewMock = ListViewMock()
        let apiMock = GithubAPIMock()
        let sut = ListViewModel(view: listViewMock, dataSource: apiMock)
        sut.fetchRepositories(next: false)
        XCTAssertFalse(listViewMock.calledShowError)
        XCTAssertTrue(listViewMock.calledShowList)
        XCTAssertTrue(listViewMock.calledShowScreenLoading)
        XCTAssertFalse(listViewMock.calledShowPaginationLoading)
        
        sut.fetchMore(indexPath: IndexPath(row: 19, section: 1))
        
        XCTAssertTrue(listViewMock.calledShowPaginationLoading)
    }
    
    func testSetFilter() {
        let listViewMock = ListViewMock()
        let apiMock = GithubAPIMock()
        let sut = ListViewModel(view: listViewMock, dataSource: apiMock)
        XCTAssertEqual(sut.filter.order, .desc)
        XCTAssertEqual(sut.filter.sort, .updated)
        sut.setFilter(Filter(order: .asc, sort: .stars))
        XCTAssertEqual(sut.filter.order, .asc)
        XCTAssertEqual(sut.filter.sort, .stars)
    }
    
}
