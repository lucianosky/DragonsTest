//
//  APIResult.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

public enum APIResult<Value> {
    case success(Value)
    case failure(Error)
}
