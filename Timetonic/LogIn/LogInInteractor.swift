//
//  LogInInteractor.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation

//MARK: - Protocols
protocol LogInInteractorInput {
    func authAppKey() async throws -> [String: Any]
    
    func authOAuthKey(email: String, password: String, appKey: String) async throws -> (String, String)
    
    func createSesskey(oauthKey: String, o_u: String) async throws -> String
}

protocol LogInInteractorDelegate: AnyObject {
    
}

//MARK: - Class
class LogInInteractor: LogInInteractorInput {
    var apiCaller: ApiCaller
    weak var delegate: LogInInteractorDelegate?
    
    //MARK: - Init
    init(apiCaller: ApiCaller) {
        self.apiCaller = apiCaller
    }
    
    

    
    //MARK: - Methods
    func authAppKey() async throws -> [String: Any] {
        return try await apiCaller.authAppKey()

    }
    
    func authOAuthKey(email: String, password: String, appKey: String) async throws -> (String, String) {
        
        do {
            let result = try await apiCaller.authOAuthKey(email: email, password: password, appKey: appKey)
            guard let oauthkey = result["oauthkey"] as? String,
                  let o_u = result["o_u"] as? String else {
                throw NSError(domain: "OAuth key is missing", code: 0) }
            
            return (oauthkey, o_u)
        } catch {
            throw error
        }
    }
    
    func createSesskey(oauthKey: String, o_u: String) async throws -> String {
        do {
            let result = try await apiCaller.createSesskey(oauthKey: oauthKey, o_u: o_u)
            guard let sessKey = result["sesskey"] as? String else {
                throw NSError(domain: "sesskey is missing", code: 0) }
            
            return sessKey
        } catch {
            throw error
        }
    }
    
}
