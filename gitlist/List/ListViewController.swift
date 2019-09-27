//
//  ListViewController.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol ListView {
    func showList()
}

class ListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: ListViewModel?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        tableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
//        tableView.register(UINib(nibName: "FilterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FilterView")
        tableView.register(UINib(nibName: "ResetFilterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ResetFilterView")
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.getRepositories(next: false, showLoading: false)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        viewModel?.showFilter.onNext(())
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return viewModel?.repositoryList.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 63
        } else if indexPath.section == 1 {
            return 171
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell, let repo = viewModel?.repositoryList[indexPath.row] else {
                return UITableViewCell()
            }
            cell.configure(repository: repo)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repo = viewModel?.repositoryList[indexPath.row] else { return }
        viewModel?.showDetails.onNext(repo)
    }
    
}

extension ListViewController: ListView {
    
    func showList() {
        tableView.reloadData()
    }
    
}
