//
//  ListBooksView.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation
import UIKit


//MARK: - Class
class ListBooksView: UIViewController {
    var presenter: ListBooksPresenterInput
    //MARK: - Init
    init(presenter: ListBooksPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    //MARK: - ConfigureViews
    private func configureViewController() {
        
    }
    
    //MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
}
//MARK: - Presenter Delegate
extension ListBooksView: ListBooksPresenterDelegate {
    
}


//MARK: - TableView Delagate
extension ListBooksView {
    
}
