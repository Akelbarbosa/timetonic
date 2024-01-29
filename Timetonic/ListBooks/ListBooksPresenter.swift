//
//  ListBooksPresenter.swift
//  Timetonic
//
//  Created by Akel Barbosa on 27/01/24.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol ListBooksPresenterInput {
    var listBooks: [ListBookEntity] { get set }
    
    func viewDidLoad()
    func managerCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func logOut()
}

protocol ListBooksPresenterDelegate: AnyObject {
    func reloadTableView()
    
    func showActivityIndicator()
    
    func hiddenActivityIndicator()
}

//MARK: - Class
class ListBooksPresenter: ListBooksPresenterInput {
    
    var interactor: ListBooksInteractorInput
    var router: ListBooksRouterInput
    
    weak var delegate: ListBooksPresenterDelegate?
    
    var listBooks: [ListBookEntity] = []
    
    //MARK: - Init
    init(interactor: ListBooksInteractorInput, router: ListBooksRouterInput) {
        self.interactor = interactor
        self.router =  router
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        delegate?.showActivityIndicator()
        guard let sessKey = SessionManager.shared.sessionKey, let o_u = SessionManager.shared.o_u else { return }
        interactor.getAllBook(sessKey: sessKey, o_u: o_u)
    }
    
    func logOut() {
        SessionManager.shared.endSession()
        goToLogin()
    }
    
    private func goToLogin() {
        DispatchQueue.main.async {[weak self] in
            self?.router.goToLogin()
        }
    }
    
    func managerCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifer, for: indexPath) as? BookCell else {
            return UITableViewCell() }
        cell.configureCell(book: listBooks[indexPath.row])
        return cell
    }
}


//MARK: - Interactor Delegate
extension ListBooksPresenter: ListBooksInteractorDelegate {
    func listBooks(listBooks: [ListBookEntity]) {
        self.listBooks = listBooks
        delegate?.reloadTableView()
        delegate?.hiddenActivityIndicator()
    }
    
    func errorToGetListBook(error: Error) {
        delegate?.hiddenActivityIndicator()
        debugPrint("Error: ", error.localizedDescription)
    }
    
    
}
