//
//  SessionManager.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation

//MARK: - Class
class SessionManager {
    static let shared = SessionManager()

    private let sessionKeyKey = "SessionKey"
    private let o_uKey = "o_u"

    var sessionKey: String? {
        get {
            return UserDefaults.standard.string(forKey: sessionKeyKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: sessionKeyKey)
        }
    }
    
    var o_u: String? {
        get {
            return UserDefaults.standard.string(forKey: o_uKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: o_uKey)
        }
    }

    func hasActiveSession() -> Bool {
        return sessionKey != nil
    }
    
    

    func startSession(sessionKey: String, o_u: String) {
        self.sessionKey = sessionKey
        self.o_u = o_u
    }

    func endSession() {
        self.sessionKey = nil
        self.o_u = nil
    }
}

