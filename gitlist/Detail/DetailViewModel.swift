//
//  DetailViewModel.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 27/09/19.
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
                
                URLSession.shared.rx
                    .response(request: URLRequest(url: repositoryContent.downloadUrl))
                    .subscribeOn(MainScheduler.instance)
                    .subscribe(onNext: { [weak self] response in
                        let str = String(data: response.data, encoding: .utf8) ?? ""
                        DispatchQueue.main.async {
                            self?.view.showReadme( str )
                        }
                    })
                    .disposed(by: self.disposeBag)

//                let data = Data(base64Encoded: repositoryContent.content) ?? Data()
//                self.view.showReadme( String(data: data, encoding: .utf8) ?? "" )
            }).disposed(by: disposeBag)
    }
    
}
