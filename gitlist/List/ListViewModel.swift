//
//  ListViewModel.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import RxSwift

struct Request {
    var query: String
    var sort: String
    var page: Int
    var itemsPerPage: Int
}

class ListViewModel {
    
    // MARK: - Public properties
    
    var showFilter = PublishSubject<Void>()
    var showDetails = PublishSubject<Repository>()
    
    var repositoryList: [Repository] = []

    
    // MARK: - Private properties
    
    private let view: ListView?
    private var dataSource: SearchAPIDataSource
    private let itemsPerPage = 20
    
    // MARK: - Constructor
    
    init(view: ListView, dataSource: SearchAPIDataSource = SearchAPI()) {
        self.view = view
        self.dataSource = dataSource
    }
    
    // MARK: - Public methods
    
    func getRepositories(next: Bool, showLoading: Bool) {
        let page = next ? getNextPageNumber() : 1
        
        
        
//        let isScreenLoading = !next
//        if showLoading {
//            presenter?.presentLoading(screen: isScreenLoading)
//        }
        let request = Request(query: "language:swift", sort: "stars", page: page, itemsPerPage: itemsPerPage)
        
        _ = dataSource.searchRepositories(query: request.query, sort: request.sort, page: request.page, itemsPerPage: request.itemsPerPage).subscribe(onNext: { results in
            if !next {
                self.repositoryList.removeAll()
            }
            self.handleResults(results)
        }, onError: handleError)
    }
    
    
//    func fetchRepositories(next: Bool, showLoading: Bool) {
//        let page = next ? getNextPageNumber() : 1
//
//        let isScreenLoading = !next
//        if showLoading {
//            presenter?.presentLoading(screen: isScreenLoading)
//        }
//
//        let request = RepositoryList.Request(query: "language:swift", sort: "stars", page: page, itemsPerPage: itemsPerPage)
//        worker.getRepositories(request: request)
//            .done({ (results) in
//                if !next {
//                    self.repositoryList.removeAll()
//                }
//                self.handleResults(results)
//            })
//            .catch(handleError)
//            .finally {
//                self.presenter?.stopLoading(screen: isScreenLoading)
//        }
//    }
    
    // MARK: - Private methods
    
    private func handleResults(_ results: SearchResults<[Repository]>) {
        repositoryList.append(contentsOf: results.items)
        view?.showList()
    }

    private func handleError(_ error: Error) {
        print("ERROR \(error) \(error.localizedDescription)")
//        presenter?.presentError(error: error)
    }
    
    private func getNextPageNumber() -> Int {
        return (repositoryList.count / itemsPerPage) + 1
    }
    
}
