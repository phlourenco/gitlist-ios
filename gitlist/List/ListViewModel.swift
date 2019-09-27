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
    
    // MARK: - Private properties
    
    private let view: ListView?
    private var dataSource: GithubAPIDataSource
    private var repositoryList: [Repository] = []
    private let itemsPerPage = 20
    
    // MARK: - Constructor
    
    init(view: ListView, dataSource: GithubAPIDataSource = GithubAPI()) {
        self.view = view
        self.dataSource = dataSource
    }
    
    // MARK: - Public methods
    
    func getSections() -> [SectionBase] {
        return [
            FilterSection(),
            RepositorySection(repositories: repositoryList)
        ]
    }
    
    func fetchRepositories(next: Bool) {
        let page = next ? getNextPageNumber() : 1
        
        if !next {
            view?.showScreenLoading()
        } else {
            view?.showPaginationLoading()
        }
        
        let request = Request(query: "language:swift", sort: "stars", page: page, itemsPerPage: itemsPerPage)
        
        _ = dataSource.searchRepositories(query: request.query, sort: request.sort, page: request.page, itemsPerPage: request.itemsPerPage).subscribe(onNext: { results in
            if !next {
                self.repositoryList.removeAll()
            }
            self.handleResults(results)
        }, onError: handleError)
    }
    
    func fetchMore(indexPath: IndexPath) {
        guard getSections()[indexPath.section].getViewModel(forRow: indexPath.row) is RepositoryCellViewModel, indexPath.row == repositoryList.count-1 else { return }
        
        fetchRepositories(next: true)
    }
    
    // MARK: - Private methods
    
    private func handleResults(_ results: SearchResults<[Repository]>) {
        repositoryList.append(contentsOf: results.items)
        view?.showList()
        self.view?.hideScreenLoading()
        self.view?.hidePaginationLoading()
    }

    private func handleError(_ error: Error) {
        print("ERROR \(error) \(error.localizedDescription)")
//        presenter?.presentError(error: error)
        self.view?.hideScreenLoading()
        self.view?.hidePaginationLoading()
    }
    
    private func getNextPageNumber() -> Int {
        return (repositoryList.count / itemsPerPage) + 1
    }
    
}
