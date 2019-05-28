//
//  UIImageViewExtension.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    convenience init(_ image: UIImage) {
        self.init()
        self.image = image
        self.contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(_ contentMode: UIView.ContentMode) {
        self.init()
        self.contentMode = contentMode
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
