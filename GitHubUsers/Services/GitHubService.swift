//
//  GitHubService.swift
//  GitHubUsers
//
//  Created by Vikram on 17/02/22.
//

import Foundation

class GitHubService {
    
    func fetchGitHubUserDetail(requestUrl: String, completion: @escaping (Bool, UserDetail?, String?) -> ()) {
        ServiceHelper.GetRequest(requestUrl: requestUrl) { (success, data, error) in
            if success, let data = data {
                do {
                    let model = try JSONDecoder().decode(UserDetail.self, from: data)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, Constants.ERROR_PARSING_DATA)
                }
            } else {
                completion(false, nil, Constants.ERROR_REQUEST_FAILED)
            }
        }
    }
    
    func fetchGitHubUsers(requestUrl: String, completion: @escaping (Bool, GitUsers?, String?) -> ()) {
        ServiceHelper.GetRequest(requestUrl: requestUrl) { (success, data, error) in
            if success, let data = data {
                do {
                    let model = try JSONDecoder().decode(GitUsers.self, from: data)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, Constants.ERROR_PARSING_DATA)
                }
            } else {
                completion(false, nil, Constants.ERROR_REQUEST_FAILED)
            }
        }
    }
}
