//
//  Date.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

extension Date {
    
    func getDifferenceInDays(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: date)
        return components.day ?? 0
    }
    
}
