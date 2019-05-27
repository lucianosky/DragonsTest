//
//  APIService.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    
}

class APIService: APIServiceProtocol {
    
    func request<T: Decodable> (
        _ urlString: String,
        onCompleted: @escaping (APIResult<T>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Error creating URL")
            onCompleted(.failure(DragonError.apiError("Error creating URL")))
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
                onCompleted(.failure(DragonError.apiError("Error parsing response")))
                return
            }

            print("data \(data)")
            print("response \(response)")
            print("statusCode \(httpResponse.statusCode)")

            let decoder = JSONDecoder()
            do {
                let jsonResponse = try decoder.decode(T.self, from: data)
                onCompleted(.success(jsonResponse))
                print("APIService success!")
            } catch let error {
                print("error \(error)")
                onCompleted(.failure(error))
            }
            
        }
        task.resume()

        
    }
    
}
