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

class RepositoryCell: ConfigurableCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Public properties
    
    var repositoryCellViewModel: RepositoryCellViewModel?
    
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
    
    override func configure(viewModel: CellViewModel, delegate: Any?) {
        guard let viewModel = viewModel as? RepositoryCellViewModel else { return }

        repositoryCellViewModel = viewModel

        loadImage()
        nameLabel.text = viewModel.repository.name
        starsLabel.text = "\(viewModel.repository.stargazersCount)"
        followersLabel.text = "\(viewModel.repository.watchersCount)"
        dateLabel.text = viewModel.getLastUpdateDate()
    }
    
    // MARK: - Private methods
    
    private func loadImage() {
        _ = repositoryCellViewModel?.image.subscribe(onNext: { image in
            DispatchQueue.main.async {
                self.iconImageView.image = image
            }
        })
    }
    
}
