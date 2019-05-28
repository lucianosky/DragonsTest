//
//  UITableViewExtension.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    convenience init(_ background: UIColor, _ rowHeight: CGFloat, _ allowsSelection: Bool = true) {
        self.init()
        self.backgroundColor = background
        self.rowHeight = rowHeight
        self.allowsSelection = allowsSelection
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
