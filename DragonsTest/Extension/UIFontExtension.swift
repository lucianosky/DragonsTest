//
//  UIFontExtension.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

enum SFont: String {
    case textFont = "cb18"
    
    var font: UIFont {
        return UIFont.abridged(rawValue)
        
    }
}

extension UIFont {
    
    static func abridged(_ abridged: String) -> UIFont {
        let sizeNum = Double(abridged.numbers) ?? 18
        let size = CGFloat(sizeNum)
        
        var type: String = "invalid"
        let name = String(abridged[0..<1]) == "c" ? "ComicBook" : "invalid"
        
        switch String(abridged[1..<2]) {
        case "b":
            type = "Bold"
        case "r":
            type = "Regular"
        default:
            break
        }
        
        return UIFont(name: "\(name)-\(type)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
