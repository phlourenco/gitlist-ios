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
//    private let disposeBag = DisposeBag()
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
//
//        // Coordinator initializes and injects viewModel
//        let signInViewModel = SignInViewModel(authentication: SessionService())
//        signInViewController.viewModel = signInViewModel
//
//        // Coordinator subscribes to events and decides when and how to navigate
//        signInViewModel.didSignIn
//            .subscribe(onNext: {
//                // Navigate to dashboard
//                print("Signed In")
//            })
//            .disposed(by: self.disposeBag)
        
//        self.navigationController.viewControllers = [listViewController]
        self.navigationController.pushViewController(listViewController, animated: true)
    }
}
