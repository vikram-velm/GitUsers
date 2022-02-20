//
//  GitHubUsers.swift
//  GitHubUsers
//
//  Created by Vikram on 17/02/22.
//

import Foundation

typealias GitUsers = [GitHubUsers]

struct GitHubUsers: Codable {
    let id: Int
    let loginName: String
    let avatarUrl: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case loginName = "login"
        case avatarUrl = "avatar_url"
        case url = "url"
    }
}
