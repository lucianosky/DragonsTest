//
//  UILabelExtension.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(_ sfont: SFont, _ color: UIColor, _ text: String = "", _ textAlignment: NSTextAlignment = .left, userEnabled: Bool = false) {
        self.init()
        self.text = text
        self.font = sfont.font
        self.textColor = color
        self.textAlignment = textAlignment
        accessibilityIdentifier = text
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = userEnabled
    }
    
}
