//
//  ListViewMock.swift
//  gitlistTests
//
//  Created by Paulo Lourenço on 29/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

@testable import gitlist

class ListViewMock: ListView {
    
    var tryAgain = false
    var calledShowList: Bool = false
    var calledShowPaginationLoading: Bool = false
    var calledHidePaginationLoading: Bool = false
    var calledShowError: Bool = false
    var calledShowErrorCount = 0
    var calledShowScreenLoading: Bool = false
    var calledHideScreenLoading: Bool = false
    
    func showList() {
        calledShowList = true
    }
    
    func showPaginationLoading() {
        calledShowPaginationLoading = true
    }
    
    func hidePaginationLoading() {
        calledHidePaginationLoading = true
    }
    
    func showError(title: String?, message: String?, tryAgainAction: (() -> Void)?) {
        calledShowErrorCount += 1
        calledShowError = true
        if tryAgain {
            tryAgain = false
            tryAgainAction?()
        }
    }
    
    func showScreenLoading() {
        calledShowScreenLoading = true
    }
    
    func hideScreenLoading() {
        calledHideScreenLoading = true
    }
    
}
