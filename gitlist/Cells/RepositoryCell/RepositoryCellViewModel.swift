//
//  RepositoryCellViewModel.swift
//  gitlist
//
//  Created by Paulo Lourenço on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryCellViewModel: CellViewModel {
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Public properties
    
    let repository: Repository
    var image = BehaviorRelay<UIImage?>(value: nil)
    
    var height: CGFloat {
        return 171
    }
    
    // MARK: - Constructor
    
    init(repository: Repository) {
        self.repository = repository
        
        if let avatarUrl = repository.owner.avatarUrl {
            URLSession.shared.rx
                .response(request: URLRequest(url: URL(string: avatarUrl)!))
                .subscribeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] response in
                    self?.image.accept(UIImage(data: response.data))
                })
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: - Constructor
    
    func getLastUpdateDate() -> String {
        let days = repository.updatedAt.getDifferenceInDays(date: Date())
        let todayStr = NSLocalizedString("today", comment: "")
        var dayStr = NSLocalizedString("day", comment: "")
        if days > 1 {
            dayStr.append("s")
        }
        
        return days == 0 ? todayStr : "\(days) \(dayStr)"
    }
    
}
