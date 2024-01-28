//
//  ListBooksInteractor.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation

//MARK: - Protocols
protocol ListBooksInteractorInput {
    
}

protocol ListBooksInteractorDelegate: AnyObject {
    
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
    
}
