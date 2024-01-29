//
//  LogInRouter.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation
import UIKit

//MARK: - Protocol
protocol LogInRouterInput {
    func createModule() -> UIViewController
    
    func goToListBook()
    
}

//MARK: - Class
class LogInRouter: LogInRouterInput {
    weak var view: UIViewController?
    weak var sceneDelegate: SceneDelegate?
    
    func createModule() -> UIViewController {
        let interactor = LogInInteractor(apiCaller: ApiCallers.shared)
        let presenter = LogInPresenter(interactor: interactor, router: self)
        let view = LogInView(presenter: presenter)
        
        interactor.delegate = presenter
        presenter.delegate = view
        
        sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        
        return view
    }
    
    func goToListBook() {
        debugPrint(#function)
        sceneDelegate?.setRootViewController(ListBooksRouter().createModule())
    }
}
