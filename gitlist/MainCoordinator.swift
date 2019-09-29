//
//  AppCoordinator.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
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
        
        let viewModel = ListViewModel(view: listViewController)
        viewModel.showFilter = showFilter
        viewModel.showDetails = showDetails
        
        listViewController.viewModel = viewModel
        navigationController.pushViewController(listViewController, animated: true)
    }
    
    private func showFilter(_ filter: Filter) {
        let filterViewController = FilterViewController.loadFromNib()
        filterViewController.delegate = (navigationController.viewControllers.first as? ListViewController)
        let viewModel = FilterViewModel(filter: filter)
        filterViewController.viewModel = viewModel
        navigationController.pushViewController(filterViewController, animated: true)
    }
    
    private func showDetails(repository: Repository) {
        let detailViewController = DetailViewController.loadFromNib()
        detailViewController.viewModel = DetailViewModel(view: detailViewController, repository: repository)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
