//
//  JSONService.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class JSONService: JSONServiceProtocol {
    
    private var dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol? = nil) {
        self.dataService = dataService ?? DataService()
    }
    
    func request<T: Decodable> (
        _ urlString: String,
        onCompleted: @escaping (DragonResult<T>) -> Void) {
        
        self.dataService.request(urlString) { (result) in
            
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
    
}
