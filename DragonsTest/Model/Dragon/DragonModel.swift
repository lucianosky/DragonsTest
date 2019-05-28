//
//  DragonModel.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonModel: DragonModelProtocol {
    
    private var jsonService: JSONServiceProtocol

    init(jsonService: JSONServiceProtocol? = nil) {
        self.jsonService = jsonService ?? JSONService()
    }

    func getDragons(onCompleted: @escaping (DragonResult<[Dragon]>) -> Void) {
        let fullURL = "\(PListHelper.baseURL)/dragoslist"
        self.jsonService.request(fullURL) { (result: DragonResult<DragonsListResponse>) in
            switch(result) {
            case .success(let dragonsListResponse):
                // compactMap will remove null elements
                let list = Dragon.listFromResponse(dragonsListResponse.dragons.compactMap{$0})
                onCompleted(.success(list))
            case .failure(let error):
                onCompleted(.failure(error))
            }
        }
    }
    
    // TODO missing test case
    // TODO fix architecture issue: JSONService x DataService
    func getDragonImage(url: String, onCompleted: @escaping (DragonResult<Data>) -> Void) {
        let dataService = DataService()
        dataService.request(url) { (result) in
            onCompleted(result)
        }
    }
    
}
