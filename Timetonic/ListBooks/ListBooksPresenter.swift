//
//  ListBooksPresenter.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation

//MARK: - Protocols
protocol ListBooksPresenterInput {
    
}

protocol ListBooksPresenterDelegate: AnyObject {
    
}

//MARK: - Class
class ListBooksPresenter: ListBooksPresenterInput {
    
    var interactor: ListBooksInteractorInput
    weak var delegate: ListBooksPresenterDelegate?
    
    //MARK: - Init
    init(interactor: ListBooksInteractorInput) {
        self.interactor = interactor
    }
    
    //MARK: - Methods
    
}


//MARK: - Interactor Delegate
extension ListBooksPresenter: ListBooksInteractorDelegate {
    
}
