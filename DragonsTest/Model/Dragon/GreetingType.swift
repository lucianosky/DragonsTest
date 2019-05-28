//
//  GreetingType.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

enum GreetingType {
    case whoa
    case groar
    case roar
    case gr
    
    var sound: String {
        switch self {
        case .whoa: return "Whoaaaaaaa"
        case .groar: return "Groarrrrrrr!"
        case .roar: return "Roarrrrrrrr!"
        case .gr: return "Grrrrrrrrrrr!"
        }
    }
    
    static var defaultString: String {
        return "gr"
    }
    
    static func from(string: String) -> GreetingType{
        switch string {
        case "whoa": return .whoa
        case "groar": return .groar
        case "roar": return .roar
        default: return .gr
        }
    }
}
