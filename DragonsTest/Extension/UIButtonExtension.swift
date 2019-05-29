//
//  UIButtonExtension.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(_ sfont: SFont, _ color: UIColor, _ title: String = "", isEnabled: Bool = true) {
        self.init(type: .custom)
        titleLabel?.font = sfont.font
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = .lightGray
        accessibilityIdentifier = title
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        clipsToBounds = true
        self.isEnabled = isEnabled
    }
    
}

class ClosureButton: UIButton {
    var closure: (() -> Void)?
    func onTouched(closure: @escaping () -> Void) {
        self.closure = closure
        self.addTarget(self, action: #selector(ClosureButton.buttonTouched), for: .touchUpInside)
    }
    @objc func buttonTouched() {
        closure?()
    }
}

