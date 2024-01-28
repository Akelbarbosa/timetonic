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

    var sessionKey: String? {
        get {
            return UserDefaults.standard.string(forKey: sessionKeyKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: sessionKeyKey)
        }
    }

    func hasActiveSession() -> Bool {
        return sessionKey != nil
    }

    func startSession(sessionKey: String) {
        self.sessionKey = sessionKey
    }

    func endSession() {
        self.sessionKey = nil
    }
}

