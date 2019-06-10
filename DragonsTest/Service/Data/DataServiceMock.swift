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
        onCompleted: @escaping (ServiceResult<T>) -> Void) {
        receivedUrl = urlString
        if isSuccess {
            if let response = successObject {
                onCompleted(.success(response as! T))
            } else {
                onCompleted(.failure(AppError.jsonError("JSONServiceMock")))
            }
        } else {
            onCompleted(.failure(AppError.jsonError("modelError")))
        }
    }
    
   func request (
        _ urlString: String,
        onCompleted: @escaping (ServiceResult<Data>) -> Void) {
        receivedUrl = urlString
        if isSuccess {
            onCompleted(.success(data!))
        } else {
            onCompleted(.failure(AppError.dataError("request")))
        }
    }
    
    // testing
    
    var isSuccess = false
    var data: Data?
    var receivedUrl: String?
    var successObject: Any?

}
