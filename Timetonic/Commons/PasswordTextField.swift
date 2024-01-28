//
//  PasswordTextField.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation
import UIKit

//MARK: - Class
class PasswordTextField: UITextField {
    
    var show: Bool = false {
        didSet {
            showPassword()
        }
    }
    
    //MARK: - Views
    var paddingImg = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var eyeIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    //MARK: - Configure Views
    private func configureViews() {
        //Eye
        paddingImg.addSubview(eyeIcon)
        eyeIcon.tintColor = .systemBlue
        eyeIcon.addTarget(self, action: #selector(toggleEye), for: .touchUpInside)
    }
    //MARK: - Configure Self
    private func configureSelf() {
        rightViewMode = .always
        rightView = paddingImg
        isSecureTextEntry = true
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        showPassword()
        configureSelf()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    @objc func toggleEye() {
        show.toggle()
    }
    
    private func showPassword() {
        if show {
            isSecureTextEntry = false
            eyeIcon.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            isSecureTextEntry = true
            eyeIcon.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }

    
}

