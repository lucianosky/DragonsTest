//
//  DragonError.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

enum DragonError: Error {
    case apiError(String)
    
    var message: String {
        switch self {
        case .apiError(let msg): return msg
        }
    }
}

extension Error {
    
    var associatedMessage: String {
        if let dragonError = self as? DragonError {
            return dragonError.message
        }
        return localizedDescription
    }
    
}
