//
//  DataServiceMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DataServiceMock: DataServiceProtocol {
    
    // protocol
    
    // TODO mock
    func jsonRequest<T: Decodable> (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<T>) -> Void) {
        receivedUrl = urlString
        if isSuccess {
            if let response = successObject {
                onCompleted(.success(response as! T))
            } else {
                onCompleted(.failure(DragonError.jsonError("JSONServiceMock")))
            }
        } else {
            onCompleted(.failure(DragonError.jsonError("modelError")))
        }
    }
    
   func request (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<Data>) -> Void) {
        receivedUrl = urlString
        if isSuccess {
            onCompleted(.success(data!))
        } else {
            onCompleted(.failure(DragonError.dataError("request")))
        }
    }
    
    // testing
    
    var isSuccess = false
    var data: Data?
    var receivedUrl: String?
    var successObject: Any?

}
