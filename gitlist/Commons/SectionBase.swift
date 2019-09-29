//
//  SectionBase.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol CellViewModel {
    var height: CGFloat { get }
}

class ConfigurableCell: UITableViewCell {

    func configure(viewModel: CellViewModel, delegate: Any?) {
        fatalError("Can't call super! Must implement your own 'configure' method.")
    }
    
}

protocol SectionBase {
    func getNumberOfRows() -> Int
    func getCellIdentifier(forRow row: Int) -> String
    func getViewModel(forRow row: Int) -> CellViewModel
}
