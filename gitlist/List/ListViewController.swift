//
//  ListViewController.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol ListView: BaseDisplayLogic {
    func showList()
    func showPaginationLoading()
    func hidePaginationLoading()
}

class ListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private lazy var refreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return ref
    }()
    
    // MARK: - Public properties
    
    var viewModel: ListViewModel?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        tableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
        tableView.register(UINib(nibName: "ResetFilterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ResetFilterView")
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchRepositories(next: false)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        viewModel?.showFilter.onNext(())
    }
    
    @objc
    private func pullToRefreshAction() {
        viewModel?.fetchRepositories(next: false)
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getSections().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getSections()[section].getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.getSections()[indexPath.section].getViewModel(forRow: indexPath.row).height ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let section = viewModel.getSections()[indexPath.section]
        let identifier = section.getCellIdentifier(forRow: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConfigurableCell else { return UITableViewCell() }
        
        cell.configure(viewModel: section.getViewModel(forRow: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let cellViewModel = viewModel.getSections()[indexPath.section].getViewModel(forRow: indexPath.row) as? RepositoryCellViewModel else { return }
        
        viewModel.showDetails.onNext(cellViewModel.repository)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.fetchMore(indexPath: indexPath)
    }
    
}

extension ListViewController: ListView {
    
    func showPaginationLoading() {
        tableView.tableFooterView = LoadingView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }
    
    func hidePaginationLoading() {
        tableView.tableFooterView = UIView()
    }
    
    func showList() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
}
