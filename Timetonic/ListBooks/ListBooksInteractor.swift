//
//  ListBooksInteractor.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation

//MARK: - Protocols
protocol ListBooksInteractorInput {
    
    func getAllBook(sessKey: String, o_u: String)
    
    
}

protocol ListBooksInteractorDelegate: AnyObject {
    func listBooks(listBooks: [ListBookEntity])
    
    func errorToGetListBook(error: Error)
}

//MARK: - Class
class ListBooksInteractor: ListBooksInteractorInput {
    var apiCaller: ApiCaller
    
    weak var delegate: ListBooksInteractorDelegate?
    
    //MARK: - INIT
    init(apiCaller: ApiCaller) {
        self.apiCaller = apiCaller
    }
    
    //MARK: - Methods
    func getAllBook(sessKey: String, o_u: String) {
        Task {
            do {
                let result = try await apiCaller.getAllBooks(sessKey: sessKey, o_u: o_u)
                delegate?.listBooks(listBooks: result)
            } catch {
                delegate?.errorToGetListBook(error: error)
            }
        }
        
        
    }
}
