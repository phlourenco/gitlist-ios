//
//  DetailViewController.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Public properties
    
    var repository: Repository?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        fillDetails()
    }
    
    // MARK: - Private methods
    
    private func fillDetails() {
        guard let repo = repository else { return }
        
        nameLabel.text = repo.name
        starsLabel.text = "\(repo.stargazersCount)"
        followersLabel.text = "\(repo.watchersCount)"
        dateLabel.text = repo.updatedAt

        
        URLSession.shared.rx
            .response(request: URLRequest(url: URL(string: repo.owner.avatarUrl)!))
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                DispatchQueue.main.async {
                    self?.iconImageView.image = UIImage(data: response.data)
                }
            })
            .disposed(by: disposeBag)
    }

    @IBAction private func shareAction(_ sender: Any) {
    }
    
    @IBAction private func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
