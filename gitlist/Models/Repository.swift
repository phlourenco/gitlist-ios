//
//  Repository.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

struct Repository: Codable {
    var name: String
    var stargazersCount: Int
    var watchersCount: Int
    var updatedAt: String
    var owner: Owner
}

struct Owner: Codable {
    var login: String
    var avatarUrl: String
}
