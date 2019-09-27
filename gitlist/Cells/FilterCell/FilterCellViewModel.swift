//
//  FilterCellViewModel.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 27/09/19.
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
            return "ESTRELAS"
        case .forks:
            return "SEGUIDORES"
        case .updated:
            return "DATA"
        }
    }
    
    func getOrderTitle() -> String {
        switch filter.order {
        case .asc:
            return "CRESCENTE"
        case .desc:
            return "DECRESCENTE"
        }
    }
    
}
