//
//  DetailViewModelTests.swift
//  gitlistTests
//
//  Created by Paulo Lourenço on 29/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//


import XCTest
@testable import gitlist
import RxTest

class DetailViewMock: DetailView {
    
    var calledShowReadme = false
    var readmeStr: String?
    
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func showReadme(_ str: String) {
        calledShowReadme = true
        readmeStr = str
        expectation.fulfill()
    }
    
}

class DetailViewModelTests: XCTestCase {
    
    func testGetReadme() {
        let expectation = XCTestExpectation(description: "Get readme")
        let detailViewMock = DetailViewMock(expectation: expectation)
        let repository = Repository(name: "Repo", stargazersCount: 10, watchersCount: 10, updatedAt: Date(), owner: Owner(login: "fulano", avatarUrl: nil))
        let apiMock = GithubAPIMock()
        let sut = DetailViewModel(view: detailViewMock, repository: repository, dataSource: apiMock)
        

        XCTAssertFalse(detailViewMock.calledShowReadme)
        sut.getReadme()
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(detailViewMock.calledShowReadme)
        XCTAssertEqual(detailViewMock.readmeStr, "teste")
    }
    
}
