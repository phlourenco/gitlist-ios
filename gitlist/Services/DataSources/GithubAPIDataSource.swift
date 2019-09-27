//
//  SearchAPIDataSource.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubAPIDataSource {
    func searchRepositories(query: String, sort: String, page: Int, itemsPerPage: Int) -> Observable<SearchResults<[Repository]>>
    
    func getReadme(ownerName: String, repositoryName: String) -> Observable<RepositoryContent>
}
