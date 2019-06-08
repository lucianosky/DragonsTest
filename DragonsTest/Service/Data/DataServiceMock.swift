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
    
    func setDragonListResult() {
        isSuccess = true
        data = TextFileHelper.DragonResponseAsData()
    }
    
    func setDragonResult() {
        isSuccess = true
        data = TextFileHelper.DragonAsData()
    }
    
    func setNotADragonResult() {
        isSuccess = true
        data = TextFileHelper.NotADragonAsData()
    }
    
}
