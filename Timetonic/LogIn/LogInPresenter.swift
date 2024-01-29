//
//  LogInPresenter.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation

//MARK: - Protocols
protocol LogInPresenterInput {
    var email: String { get set }
    var password: String { get set }
    
    func validateCredentials()
}

protocol LogInPresenterDelegate: AnyObject {
    func logInErrors(error: LogInErrors)
    
    func showActivityIndicator()
    
    func hiddenActivityIndicator()
}


//MARK: - Class
class LogInPresenter: LogInPresenterInput {
    var email: String = ""
    var password: String = ""
    
    var interactor: LogInInteractor
    var router: LogInRouterInput
    weak var delegate: LogInPresenterDelegate?
    
    //MARK: - Init
    init(interactor: LogInInteractor, router: LogInRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    
    //MARK: - Methods
    func validateCredentials() {
        delegate?.showActivityIndicator()
        
        guard !email.isEmpty else {
            delegate?.logInErrors(error: .emptyEmail)
            return
        }
        
        guard email.validateEmail() else {
            delegate?.logInErrors(error: .invalidateEmail)
            return
        }
        
        guard !password.isEmpty else {
            delegate?.logInErrors(error: .emptyPassword)
            return
        }
        
        handlerAuth()
    }
    
    private func handlerAuth() {
        Task {
            do {
                let appKey = try await authAppKey()
                let (oAuthKey, o_u) = try await authOAuth(appKey: appKey)                
                let sessKey = try await createSesskey(oauthKey: oAuthKey, o_u: o_u)
                
                SessionManager.shared.startSession(sessionKey: sessKey, o_u: o_u)
                goToListBookView()

            } catch {
                delegate?.hiddenActivityIndicator()
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func authAppKey() async throws -> String {
        do {
            let result = try await interactor.authAppKey()
            
            guard let appKey = result["appkey"] as? String else {
                throw NSError(domain: "Appkey is missing", code: 0)
            }
            
            return appKey
            
        } catch {
            throw error
        }
        
    }
    
    private func authOAuth(appKey: String) async throws -> (String, String) {
        do {
            return try await interactor.authOAuthKey(email: email, password: password, appKey: appKey)
    
        } catch {
            throw error
        }
    }
    
    private func createSesskey(oauthKey: String, o_u: String) async throws -> String {
        do {
            return try await interactor.createSesskey(oauthKey: oauthKey, o_u: o_u)
    
        } catch {
            throw error
        }
    }
    
    private func goToListBookView() {

        DispatchQueue.main.async {[weak self] in
            self?.delegate?.hiddenActivityIndicator()
            self?.router.goToListBook()
        }
       
    }
    
    
}

//MARK: - Interector Delegate
extension LogInPresenter: LogInInteractorDelegate {
    
}


//MARK: - Enums
enum LogInErrors: String {
    // Email
    
    case invalidateEmail = "Invalidate Email"
    case emptyEmail = "Email field is empty"
    
    // Password
    case emptyPassword = "Password field is empty"
}
