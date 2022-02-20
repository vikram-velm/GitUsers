//
//  Constants.swift
//  GitHubUsers
//
//  Created by Vikram on 19/02/22.
//

import Foundation

struct Constants {
    
    //API
    static let API_BASE_URL = "https://api.github.com/users"
    static let PARAM_SINCE = "since"
    static let PARAM_PERPAGE = "per_page"
    
    //CUSTOM CELL
    static let CELL_IDENTIFIER = "GitHubCustomCell"
    
    //STORYBOARD
    static let MAIN_STORYBOARD = "Main"
    static let DETAIL_CONTROLLER_IDENTIFIER = "DetailViewController"
    
    //ERROR
    static let ERROR_PARSING_DATA = "Error Parsing Data"
    static let ERROR_REQUEST_FAILED = "Error Request Failed"
    
    //ALERT
    static let ALERT_TITLE = "GitHub User"
    static let NO_NETWORK_ALERT = "Please connect to network"
    static let ALERT_BUTTON_TTILE_OK = "Ok"
}
