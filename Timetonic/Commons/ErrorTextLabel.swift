//
//  ErrorTextLabel.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation
import UIKit

//MARK: - Class
class ErrorMessageLabel: UILabel {

    //MAR: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .systemRed
        adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
