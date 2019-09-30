//
//  FilterCell.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol FilterCellDelegate: class {
    func didTapFilterCase()
}

class FilterCell: ConfigurableCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var filteringLabel: UILabel! {
        didSet {
            filteringLabel.text = NSLocalizedString("filtering", comment: "")
        }
    }
    
    @IBOutlet weak var sortButton: OutlineButton! {
        didSet {
            sortButton.setTitle(NSLocalizedString("sort", comment: ""), for: .normal)
        }
    }
    
    @IBOutlet weak var orderButton: OutlineButton! {
        didSet {
            orderButton.setTitle(NSLocalizedString("order", comment: ""), for: .normal)
        }
    }
    
    // MARK: - Properties
    
    weak var delegate: FilterCellDelegate?
    
    // MARK: - Methods
    
    override func configure(viewModel: CellViewModel, delegate: Any?) {
        guard let viewModel = viewModel as? FilterCellViewModel else { return }
        
        self.delegate = (delegate as? FilterCellDelegate)

        sortButton.setTitle(viewModel.getSortTitle(), for: .normal)
        orderButton.setTitle(viewModel.getOrderTitle(), for: .normal)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        delegate?.didTapFilterCase()
    }
    
}
