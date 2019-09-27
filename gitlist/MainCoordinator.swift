//
//  AppCoordinator.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit
import RxSwift

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    private let disposeBag = DisposeBag()
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    var navigationController = UINavigationController()
    
    func start() {
        self.navigationController.navigationBar.isHidden = true
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        
        showList()
    }
    
    func showList() {
        let listViewController = ListViewController.loadFromNib()
        
        let viewModel = ListViewModel()
        viewModel.showFilter.subscribe(onNext: { _ in
            self.showFilter()
        }).disposed(by: disposeBag)
        
        viewModel.showDetails.subscribe(onNext: { _ in
            self.showDetails()
        }).disposed(by: disposeBag)
        
        listViewController.viewModel = viewModel
        
        navigationController.pushViewController(listViewController, animated: true)
    }
    
    private func showFilter() {
        let filterViewController = FilterViewController.loadFromNib()
        navigationController.pushViewController(filterViewController, animated: true)
    }
    
    private func showDetails() {
        let detailViewController = DetailViewController.loadFromNib()
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
