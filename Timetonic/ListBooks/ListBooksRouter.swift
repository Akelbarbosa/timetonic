//
//  ListBooksRouter.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation
import UIKit

//MARK: - Protocols

//MARK: - Class
class ListBooksRouter {
    
    func createModule() -> UIViewController {
        let interactor = ListBooksInteractor(apiCaller: ApiCallers.shared)
        let presenter = ListBooksPresenter(interactor: interactor)
        let view = ListBooksView(presenter: presenter)
    
        return view
    }
    
    
    
}
