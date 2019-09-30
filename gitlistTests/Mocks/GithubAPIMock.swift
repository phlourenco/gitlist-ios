//
//  GithubAPIMock.swift
//  gitlistTests
//
//  Created by Paulo Lourenço on 29/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

@testable import gitlist
import Foundation
import RxSwift
import RxTest

class GithubAPIMock: GithubAPIDataSource {
    
    var error = false
    
    func searchRepositories(query: String, sort: String, order: String, page: Int, itemsPerPage: Int) -> Observable<SearchResults<[Repository]>> {
        return Observable.create({ observer -> Disposable in
            var repositoryList = [Repository]()
                for i in 0..<itemsPerPage*page {
                    repositoryList.append(Repository(name: "Repo #\(i)", stargazersCount: 10, watchersCount: 10, updatedAt: Date(), owner: Owner(login: "fulano", avatarUrl: nil)))
                }
            let results = SearchResults<[Repository]>(totalCount: repositoryList.count, items: repositoryList)
            if !self.error {
                observer.onNext(results)
            } else {
                observer.onError(HTTPClient.Errors.parseError)
            }
            
            
            return Disposables.create { }
        })
    }
    
    func getReadme(ownerName: String, repositoryName: String) -> Observable<RepositoryContent> {
        return Observable.create({ observer -> Disposable in
            let result = RepositoryContent(downloadUrl: URL(string: "https://google.com")!)
            if !self.error {
                observer.onNext(result)
            } else {
                observer.onError(HTTPClient.Errors.parseError)
            }
            
            return Disposables.create { }
        })
    }
    
    
    func getContent(url: URL) -> Observable<String> {
        return Observable.create({ observer -> Disposable in
            observer.onNext("teste")
            return Disposables.create { }
        })
    }
    
}
