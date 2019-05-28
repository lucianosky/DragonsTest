//
//  DataService.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {

    func request (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<Data>) -> Void)

}

class DataServiceMock: DataServiceProtocol {
    
    // protocol
    
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
        data = TextFileHelper.DragonListAsData()
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

class DataService: DataServiceProtocol {
    
    func request (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<Data>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Error creating URL")
            onCompleted(.failure(DragonError.dataError("Error creating URL")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in

            if let error = error {
                print("error \(error)")
                onCompleted(.failure(error))
                return
            }
            
            guard let data = data,
                let response = response,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                print("error parsing response")
                onCompleted(.failure(DragonError.dataError("Error parsing response")))
                return
            }

            print("data \(data)")
            print("response \(response)")
            print("statusCode \(httpResponse.statusCode)")
            onCompleted(.success(data))
            
        }
        task.resume()

        
    }
    
}
