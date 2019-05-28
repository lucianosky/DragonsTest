//
//  PListHelper.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class PListHelper {
    
    static var baseURL: String = {
        guard let infoPlist =  Bundle.main.infoDictionary,
            let url = infoPlist["BASE_URL"] as? String
            else {
                // TODO: revisar fatal error
                fatalError("BASE_URL not loaded")
        }
        return url
    }()
    
}
