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

protocol DetailView {
    func showReadme(_ str: String)
}

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.items?.first?.title = NSLocalizedString("detail", comment: "")
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var starsTitleLabel: UILabel! {
        didSet {
            starsTitleLabel.text = NSLocalizedString("stars", comment: "").capitalized
        }
    }
    
    @IBOutlet weak var followersTitleLabel: UILabel! {
        didSet {
            followersTitleLabel.text = NSLocalizedString("followers", comment: "")
        }
    }
    
    @IBOutlet weak var dateTitleLabel: UILabel! {
        didSet {
            dateTitleLabel.text = NSLocalizedString("last_commit", comment: "")
        }
    }
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readmeTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.setTitle(NSLocalizedString("share", comment: ""), for: .normal)
        }
    }
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Public properties
    
    var viewModel: DetailViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        fillDetails()
        viewModel?.getReadme()
    }
    
    // MARK: - Private methods
    
    private func fillDetails() {
        guard let repo = viewModel?.repository else { return }
        
        nameLabel.text = repo.name
        starsLabel.text = "\(repo.stargazersCount)"
        followersLabel.text = "\(repo.watchersCount)"
        dateLabel.text = "\(repo.updatedAt.getDifferenceInDays(date: Date()))"

        if let avatarUrl = repo.owner.avatarUrl {
            URLSession.shared.rx
                .response(request: URLRequest(url: URL(string: avatarUrl)!))
                .subscribeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] response in
                    DispatchQueue.main.async {
                        self?.iconImageView.image = UIImage(data: response.data)
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    @IBAction private func shareAction(_ sender: Any) {
    }
    
    @IBAction private func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension DetailViewController: DetailView {
    
    func showReadme(_ str: String) {
        readmeTextView.text = str
    }
    
}
