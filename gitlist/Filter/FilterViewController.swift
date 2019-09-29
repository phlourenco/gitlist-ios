//
//  FilterViewController.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol FilterViewDelegate {
    func didChangeFilter(_ newFilter: Filter)
}

protocol FilterView: BaseDisplayLogic {
    
}

class FilterViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var sortButtons: [SelectableButton]!
    @IBOutlet var orderButtons: [SelectableButton]!
    
    // MARK: - Private properties
    
    private var newFilter: Filter?
    
    // MARK: - Public properties
    
    var delegate: FilterViewDelegate?
    
    var viewModel: FilterViewModel? {
        didSet {
            newFilter = viewModel?.filter
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCurrentFilterButtons()
    }
    
    // MARK: - Methods
    
    @IBAction func sortAction(_ sender: UIButton) {
        newFilter?.sort = Sort.allCases[sender.tag]
        sortButtons.filter { $0 != sender }.forEach { button in
            button.isSelected = false
        }
        selectCurrentFilterButtons()
    }
    
    @IBAction func orderAction(_ sender: UIButton) {
        newFilter?.order = Order.allCases[sender.tag]
        orderButtons.filter { $0 != sender }.forEach { button in
            button.isSelected = false
        }
        selectCurrentFilterButtons()
    }
    
    @IBAction func applyAction(_ sender: Any) {
        guard let filter = newFilter else { return }
        viewModel?.filter = filter
        delegate?.didChangeFilter(filter)
        back()
    }
    
    @IBAction func backAction(_ sender: Any) {
        back()
    }
    
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func selectCurrentFilterButtons() {
        if let currentFilter = newFilter {
            sortButtons.first { $0.tag == Sort.allCases.firstIndex(of: currentFilter.sort) }?.isSelected = true
            orderButtons.first { $0.tag == Order.allCases.firstIndex(of: currentFilter.order) }?.isSelected = true
        }
    }

}

//extension FilterViewController: FilterView {
//
//}
