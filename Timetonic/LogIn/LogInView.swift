//
//  LogInView.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation
import UIKit

//MARK: - Class
class LogInView: UIViewController {
    var presenter: LogInPresenterInput
    
    var heightTextField: CGFloat = 40
    
    
    
    //MARK: - Views
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let emailTextField: UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordTextField = PasswordTextField()
    
    private let logInButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let emailErrorLabel = ErrorMessageLabel()
    
    private let passwordErrorLabel = ErrorMessageLabel()
    
    private let containerStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    //MARK: - Configure Views
    private func configureViews() {
        // Stack
        view.addSubview(containerStackView)
        containerStackView.axis = .vertical
        containerStackView.spacing = 20
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
        ])
        
        //Logo
        containerStackView.addArrangedSubview(logoImage)
        logoImage.image = UIImage(named: "timetonic-logo")
        logoImage.contentMode = .scaleAspectFit
        logoImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        //Email
        containerStackView.addArrangedSubview(emailTextField)
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = .secondarySystemGroupedBackground
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        emailTextField.tag = 0
        emailTextField.delegate = self
        emailTextField.paddingLeft(10)
        emailTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
        
        // Error
        containerStackView.addArrangedSubview(emailErrorLabel)
        
        //password
        containerStackView.addArrangedSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .secondarySystemGroupedBackground
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.tag = 1
        passwordTextField.delegate = self
        passwordTextField.paddingLeft(10)
        passwordTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true

        // Error Password
        containerStackView.addArrangedSubview(passwordErrorLabel)
        
        //button
        containerStackView.addArrangedSubview(logInButton)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitleColor(.black, for: .disabled)
        logInButton.backgroundColor = .systemGreen
        logInButton.layer.cornerRadius = 10
        logInButton.isEnabled = true
        logInButton.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemGroupedBackground
    }
    //MARK: - Init
    init(presenter: LogInPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("\(self) dealloc")
    }
    
    //MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureViewController()
    }
    
    //MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @objc private func logInButtonAction() {
        presenter.validateCredentials()
    }
    
    private func resetErrorLabel() {
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
    }
    

    
}

//MARK: - Presenter Delegate
extension LogInView: LogInPresenterDelegate {
    func logInErrors(error: LogInErrors) {
        switch error {
        case .invalidateEmail:
            emailErrorLabel.text = error.rawValue
        case .emptyEmail:
            emailErrorLabel.text = error.rawValue
        case .emptyPassword:
            passwordErrorLabel.text = error.rawValue
        }
    }
    
    
}


//MARK: - TextField Delegate
extension LogInView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetErrorLabel()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField.tag {
        case 0:
            presenter.email = text
            
        case 1:
            presenter.password = text
            
        default:
            break
        }
        
    }
    
    
}

