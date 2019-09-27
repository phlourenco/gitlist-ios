//
//  SearchAPI.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import RxSwift

class GithubAPI: GithubAPIDataSource {
    
    func searchRepositories(query: String, sort: String, page: Int, itemsPerPage: Int) -> Observable<SearchResults<[Repository]>> {
        let params: [String: Any] = [
            "q": query,
            "sort": sort,
            "page": page,
            "per_page": itemsPerPage
        ]
        
        return HTTPClient().request(url: "https://api.github.com/search/repositories", method: .get, parameters: params, headers: nil, parseAs: SearchResults<[Repository]>.self, keyDecodingStrategy: .convertFromSnakeCase)
    }
    
    func getReadme(ownerName: String, repositoryName: String) -> Observable<RepositoryContent> {
        return HTTPClient().request(url: "https://api.github.com/repos/\(ownerName)/\(repositoryName)/readme", method: .get, headers: nil, parseAs: RepositoryContent.self, keyDecodingStrategy: .convertFromSnakeCase)
    }
    
}
