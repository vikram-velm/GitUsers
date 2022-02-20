//
//  ServiceHelper.swift
//  GitHubUsers
//
//  Created by Vikram on 19/02/22.
//

import Foundation

class ServiceHelper {
    static func GetRequest(requestUrl: String, completion: @escaping (Bool, Data?, String?) -> ()) {
        let url = URL(string: requestUrl)
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                completion(false, nil, "Error")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                completion(true, data, nil)
            }
            
        }
        task.resume()
    }
}
