//
//  DataService.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DataService: DataServiceProtocol {
    
    private var urlSessionWrappper: URLSessionWrappperProtocol
    
    init(urlSessionWrappper: URLSessionWrappperProtocol? = nil) {
        self.urlSessionWrappper = urlSessionWrappper ?? URLSessionWrapper()
    }

    func jsonRequest<T: Decodable> (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<T>) -> Void) {
        
        self.request(urlString) { (result) in
            
            switch(result) {
                
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let jsonResponse = try decoder.decode(T.self, from: data)
                    onCompleted(.success(jsonResponse))
                    print("APIService success!")
                } catch let error {
                    print("error \(error)")
                    onCompleted(.failure(error))
                }
                
            case .failure(let error):
                onCompleted(.failure(error))
            }
            
        }
    }
    
    func request (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<Data>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Error creating URL")
            onCompleted(.failure(DragonError.dataError("Error creating URL")))
            return
        }
        
        print(urlString)
//        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
        let task = urlSessionWrappper.dataTask(with: url){ (data, response, error) in

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

            // print("data \(data)")
            // print("response \(response)")
            print("statusCode \(httpResponse.statusCode)")
            onCompleted(.success(data))
            
        }
        task.resume()

        
    }
    
}
