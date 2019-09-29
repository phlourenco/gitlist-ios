//
//  FilterCell.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    func didTapFilterCase()
}

class FilterCell: ConfigurableCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var sortButton: OutlineButton!
    @IBOutlet weak var orderButton: OutlineButton!
    
    // MARK: - Properties
    
    var delegate: FilterCellDelegate?
    
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
