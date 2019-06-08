//
//  DataServiceProtocol.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    
    func jsonRequest<T: Decodable> (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<T>) -> Void)

    func request (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<Data>) -> Void)
    
}
