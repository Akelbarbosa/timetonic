//
//  UITextField+PaddingLeft.swift
//  Timetonic
//
//  Created by Akel Barbosa on 26/01/24.
//

import Foundation
import UIKit

extension UITextField {
    func paddingLeft(_ padding: Int = 0) {
        self.leftViewMode = .always
        let spacePadding = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 1))
        self.leftView = spacePadding
    }
}
