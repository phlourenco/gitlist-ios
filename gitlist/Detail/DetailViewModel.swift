//
//  DetailViewModel.swift
//  gitlist
//
//  Created by Paulo Lourenço on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let dataSource: GithubAPIDataSource
    private let view: DetailView
    
    // MARK: - Public properties
    
    let repository: Repository
    
    // MARK: - Constructor
    
    init(view: DetailView, repository: Repository, dataSource: GithubAPIDataSource = GithubAPI()) {
        self.view = view
        self.repository = repository
        self.dataSource = dataSource
    }
    
    // MARK: - Methods
    
    func getReadme() {
        dataSource.getReadme(ownerName: repository.owner.login, repositoryName: repository.name)
            .subscribe(onNext: { repositoryContent in
                self.dataSource.getContent(url: repositoryContent.downloadUrl).subscribe(onNext: { [weak self] str in
                    DispatchQueue.main.async {
                        self?.view.showReadme( str )
                    }
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }
    
}
