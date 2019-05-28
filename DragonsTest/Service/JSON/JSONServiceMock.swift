//
//  JSONServiceMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class JSONServiceMock: JSONServiceProtocol {
    
    // protocol

    func request<T: Decodable> (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<T>) -> Void)
    {
        receivedUrl = urlString
        if isSuccess {
            if let response = successObject {
                onCompleted(.success(response as! T))
            } else {
                onCompleted(.failure(DragonError.modelError("JSONServiceMock")))
            }
        } else {
            onCompleted(.failure(DragonError.modelError("modelError")))
        }
    }
    
    // testing
    
    var isSuccess = false
    var successObject: Any?
    var receivedUrl: String?

}
