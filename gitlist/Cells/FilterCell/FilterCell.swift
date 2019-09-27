//
//  FilterCell.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class FilterCell: ConfigurableCell {

    @IBOutlet weak var sortButton: OutlineButton!
    @IBOutlet weak var orderButton: OutlineButton!
    
    override func configure(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? FilterCellViewModel else { return }

        sortButton.setTitle(viewModel.getSortTitle(), for: .normal)
        orderButton.setTitle(viewModel.getOrderTitle(), for: .normal)
    }
    
}
