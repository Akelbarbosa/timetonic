//
//  ListBooksRouter.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol ListBooksRouterInput {
    func createModule() -> UIViewController
    
    func goToLogin()
    
}

//MARK: - Class
class ListBooksRouter: ListBooksRouterInput {
    weak var sceneDelegate: SceneDelegate?
    
    
    func createModule() -> UIViewController {
        let interactor = ListBooksInteractor(apiCaller: ApiCallers.shared)
        let presenter = ListBooksPresenter(interactor: interactor, router: self)
        let view = ListBooksView(presenter: presenter)
    
        interactor.delegate = presenter
        presenter.delegate = view
        
        sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        return view
    }
    
    
    func goToLogin() {
        sceneDelegate?.setRootViewController(LogInRouter().createModule())
    }
    
}
