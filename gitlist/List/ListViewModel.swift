//
//  ListViewModel.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import RxSwift

class ListViewModel {
    
    // MARK: - Public properties
    
    var showFilter: ((Filter) -> Void)?
    var showDetails: ((Repository) -> Void)?
    
    // MARK: - Private properties
    
    private let view: ListView?
    private var dataSource: GithubAPIDataSource
    private var repositoryList: [Repository] = []
    private let itemsPerPage = 20
    
    var filter = Filter(order: .desc, sort: .updated)
    
    // MARK: - Constructor
    
    init(view: ListView, dataSource: GithubAPIDataSource = GithubAPI()) {
        self.view = view
        self.dataSource = dataSource
    }
    
    // MARK: - Public methods
    
    func getSections() -> [SectionBase] {
        return [
            FilterSection(filter: filter),
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
        
        _ = dataSource.searchRepositories(query: "language:swift", sort: filter.sort.rawValue, order: filter.order.rawValue, page: page, itemsPerPage: itemsPerPage).subscribe(onNext: { results in
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
    
    func setFilter(_ filter: Filter) {
        self.filter = filter
        fetchRepositories(next: false)
    }
    
    // MARK: - Private methods
    
    private func handleResults(_ results: SearchResults<[Repository]>) {
        repositoryList.append(contentsOf: results.items)
        view?.showList()
        self.view?.hideScreenLoading()
        self.view?.hidePaginationLoading()
    }

    private func handleError(_ error: Error) {
        self.view?.hideScreenLoading()
        self.view?.hidePaginationLoading()
        self.view?.showError(title: "Erro", message: "Ocorreu um erro. Verifique sua conexão e tente novamente.", tryAgainAction: {
            self.fetchRepositories(next: false)
        })
    }
    
    private func getNextPageNumber() -> Int {
        return (repositoryList.count / itemsPerPage) + 1
    }
    
}
