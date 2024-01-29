//
//  ApiCallers.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation

//MARK: - Protocols
protocol ApiCaller {
    
    var url: String { get }
    
    func authAppKey() async throws -> [String: Any]
    
    func authOAuthKey(email: String, password: String, appKey: String) async throws -> [String: Any]
    
    func createSesskey(oauthKey: String, o_u: String) async throws -> [String: Any]
    
    func getAllBooks(sessKey: String, o_u: String) async throws -> [ListBookEntity] 
}

//MARK: - Class
class ApiCallers: ApiCaller {
    static let shared = ApiCallers()
    
    let url = "https://timetonic.com/live/api.php"
    let urlImageBase = "https://timetonic.com/live"
    //MARK: - Fetch
    private func apiRequest(url: String, parameters: [String: String]) async throws -> [String: Any] {
        guard let url = URL(string: url) else {
            throw NSError(domain: "Invalid URL", code: 0)
            
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let parameterString = parameters.map { (key, value) in
            return "\(key)=\(value)"
        }.joined(separator: "&")

        request.httpBody = parameterString.data(using: .utf8)

        let (data, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

        guard let result = json else {
            throw NSError(domain: "Invalid JSON", code: 0, userInfo: nil)
        }

        return result
        
    }
    
    //MARK: - Authentication
    func authAppKey() async throws -> [String: Any] {
        let parameters = [
            "version": "1.47",
            "req": "createAppkey",
            "appname": "android"
        ]

        return try await apiRequest(url: url, parameters: parameters)
    }

    
    func authOAuthKey(email: String, password: String, appKey: String) async throws -> [String: Any] {
        let parameters = [
            "version": "1.47",
            "req": "createOauthkey",
            "login": email,
            "pwd": password,
            "appkey": appKey
        ]
        
        return try await apiRequest(url: url, parameters: parameters)
        
    }
    
    func createSesskey(oauthKey: String, o_u: String) async throws -> [String: Any] {
        let parameters = [
            "version": "1.47",
            "req": "createSesskey",
            "o_u": o_u,
            "u_c": o_u,
            "oauthkey": oauthKey
        ]
        
        return try await apiRequest(url: url, parameters: parameters)
    }
    
    //MARK: - Get All Books
    func getAllBooks(sessKey: String, o_u: String) async throws -> [ListBookEntity] {
        var listBooks: [ListBookEntity] = []
        
        let parameters = [
            "version": "1.47",
            "req": "getAllBooks",
            "o_u": o_u,
            "u_c": o_u,
            "sesskey": sessKey
        ]

        let result = try await apiRequest(url: url, parameters: parameters)
        guard let allBooks = result["allBooks"] as? [String: Any] else {
            throw NSError(domain: "Error to try decoder", code: 0)
            
        }
        

        if let books = allBooks["books"] as? [[String: Any]] {
            for book in books {
                if let ownerPrefs = book["ownerPrefs"] as? [String: Any] {
                    
                    guard let title = ownerPrefs["title"] as? String,
                          let urlImage = ownerPrefs["oCoverImg"] as? String else {
                        throw NSError(domain: "Error to try decoder", code: 0)
                    }
                   
                    let urlImageFormatting = urlImage.replacingOccurrences(of: "/dev", with: "")
                    listBooks.append(ListBookEntity(title: title, imageUrl: urlImageBase + urlImageFormatting))
      
                }
            }
        }

        return listBooks
    }
}

