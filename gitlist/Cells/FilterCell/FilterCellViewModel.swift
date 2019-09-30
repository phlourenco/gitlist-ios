//
//  FilterCellViewModel.swift
//  gitlist
//
//  Created by Paulo Lourenço on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class FilterCellViewModel: CellViewModel {
    
    var height: CGFloat {
        return 63
    }
    
    let filter: Filter
    
    init(filter: Filter) {
        self.filter = filter
    }
    
    func getSortTitle() -> String {
        switch filter.sort {
        case .stars:
            return NSLocalizedString("stars", comment: "")
        case .forks:
            return NSLocalizedString("followers", comment: "").uppercased()
        case .updated:
            return NSLocalizedString("date", comment: "")
        }
    }
    
    func getOrderTitle() -> String {
        switch filter.order {
        case .asc:
            return NSLocalizedString("ascending", comment: "")
        case .desc:
            return NSLocalizedString("descending", comment: "")
        }
    }
    
}
