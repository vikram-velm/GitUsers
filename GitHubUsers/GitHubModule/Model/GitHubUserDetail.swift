//
//  GitHubUserDetail.swift
//  GitHubUsers
//
//  Created by Vikram on 18/02/22.
//

import Foundation

typealias UserDetail = GitHubUserDetail

struct GitHubUserDetail: Codable {
    let id: Int
    let loginName: String
    let avatarUrl: String
    let url: String
    let name: String
    let blog: String
    let followers: Int
    let following: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case loginName = "login"
        case avatarUrl = "avatar_url"
        case url = "url"
        case name = "name"
        case blog = "blog"
        case followers = "followers"
        case following = "following"
        case createdDate = "created_at"
    }
}
