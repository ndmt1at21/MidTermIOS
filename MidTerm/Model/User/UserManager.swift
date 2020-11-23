//
//  UserManager.swift
//  MidTerm
//
//  Created by Minh Tri on 11/23/20.
//

import Foundation

protocol UserDelegate {
    func didSignInSuccess(_ userManager: UserManager)
    func didSignInFailed(_ userManager: UserManager, error: String)
}

class UserManager {
    private let apiKey = "5fbb6820c09c200016d40734"
    private var baseURL: String {
        return "https://\(apiKey).mockapi.io/"
    }
    private var user: String = ""
    private var password: String = ""
    
    var delegate: UserDelegate?
    
    func fetchUser(user: String, pass: String) {
        self.user = user
        self.password = pass
        
        let urlStr = baseURL + "users"
        performRequest(with: urlStr)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let urlRequest = URLRequest(url: url)
            let task = session.dataTask(with: urlRequest) { (data, respone, error) in
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let users = try decoder.decode([User].self, from: data)
            let user = users.filter{ $0.username == self.user }.first
            
            if user?.username == self.user && user?.password == self.password {
                
                delegate?.didSignInSuccess(self)
            } else {
                delegate?.didSignInFailed(self, error: "Wrong username or password")
            }
        } catch {
            delegate?.didSignInFailed(self, error: error.localizedDescription)
        }
    }
}
