//
//  RepositorySection.swift
//  gitlist
//
//  Created by Paulo Lourenço on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

class RepositorySection: SectionBase {
    
    var repositories: [Repository]
    
    init(repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func getNumberOfRows() -> Int {
        return repositories.count
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        return "RepositoryCell"
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel {
        return RepositoryCellViewModel(repository: repositories[row])
    }
    
}
