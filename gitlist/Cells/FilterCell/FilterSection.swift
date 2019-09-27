//
//  FilterSection.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

class FilterSection: SectionBase {
    
    let filter: Filter
    
    init(filter: Filter) {
        self.filter = filter
    }
    
    func getNumberOfRows() -> Int {
        return 1
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        return "FilterCell"
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel {
        return FilterCellViewModel(filter: filter)
    }
    
}
