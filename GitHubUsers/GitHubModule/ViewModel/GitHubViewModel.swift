//
//  GitHubViewModel.swift
//  GitHubUsers
//
//  Created by Vikram on 17/02/22.
//

import Foundation
import UIKit

class GitHubViewModel: NSObject {
    var gitHubService = GitHubService()
    
    var gitUsers = GitUsers()
    
    var reloadTableView: (() -> Void)?
    
    var userDetail: UserDetail?
    
    var populateData:(() -> Void)?
    
    func fetchUserList(from: Int, perPage: Int) {
        gitHubService.fetchGitHubUsers(requestUrl:"\(Constants.API_BASE_URL)?\(Constants.PARAM_SINCE)=\(from)&\(Constants.PARAM_PERPAGE)=\(perPage)") { [self] (success, model, error) in
            if success, let model = model {
                for users in model {
                    gitUsers.append(users)
                }
                self.reloadTableView?()
            }
        }
    }
    
    func fetchUserDetail(url: String) {
        gitHubService.fetchGitHubUserDetail(requestUrl: url) { (success, model, error) in
            if success, let model = model {
                self.userDetail = model
                self.populateData?()
            }
        }
    }
}
