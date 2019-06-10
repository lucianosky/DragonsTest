//
//  AppError.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

enum AppError: Error {
    case dataError(String)
    case jsonError(String)
    case modelError(String)
    case viewModelError(String)

    var message: String {
        switch self {
        case .dataError(let msg): return msg
        case .jsonError(let msg): return msg
        case .modelError(let msg): return msg
        case .viewModelError(let msg): return msg
        }
    }
}

extension Error {
    
    var associatedMessage: String {
        if let dragonError = self as? AppError {
            return dragonError.message
        }
        return localizedDescription
    }
    
}
