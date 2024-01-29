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
    
    deinit {
        debugPrint("\(self) dealloc")
    }
    //MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var logOutButton: UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView?
    
    //MARK: - ConfigureViews
    private func configureViews() {
        
        //Log Out Button
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.setTitleColor(.systemRed, for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutButtonAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
        
        //Table View
        view.addSubview(tableView)
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.identifer)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureViewController() {
        title = "List Books"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
    }
    
    //MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureViews()
        presenter.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @objc private func logOutButtonAction() {
        presenter.logOut()
    }
    
    private func activateActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        
        tableView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        self.activityIndicator = activityIndicator

    }
    
    private func desactivateActivityIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
        
    }
    
}
//MARK: - Presenter Delegate
extension ListBooksView: ListBooksPresenterDelegate {
    func showActivityIndicator() {
        DispatchQueue.main.async {[weak self] in
            self?.activateActivityIndicator()
        }
    }
    
    func hiddenActivityIndicator() {
        DispatchQueue.main.async {[weak self] in
            self?.desactivateActivityIndicator()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
}


//MARK: - TableView Delagate
extension ListBooksView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.listBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.managerCell(tableView, indexPath: indexPath)
    }
    
    
}
