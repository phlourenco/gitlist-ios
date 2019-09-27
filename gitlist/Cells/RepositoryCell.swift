//
//  RepositoryCell.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryCell: UITableViewCell {
    
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
    
    // MARK: - View lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = ""
        starsLabel.text = ""
        followersLabel.text = ""
        dateLabel.text = ""
    }
    
    // MARK: - Public methods
    
    func configure(repository: Repository) {
        self.repository = repository
        loadImage()
        nameLabel.text = repository.name
        starsLabel.text = "\(repository.stargazersCount)"
        followersLabel.text = "\(repository.watchersCount)"
        dateLabel.text = repository.updatedAt
    }
    
    // MARK: - Private methods
    
    private func loadImage() {
        guard let repo = repository else { return }
        
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
    
}
