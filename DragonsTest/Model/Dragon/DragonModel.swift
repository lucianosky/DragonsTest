//
//  DragonModel.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol DragonModelProtocol {
    
}

class DragonModel: DragonModelProtocol {
    
    private var jsonService: JSONServiceProtocol

    init(jsonService: JSONServiceProtocol? = nil) {
        self.jsonService = jsonService ?? JSONService()
    }

    func getDragons(onCompleted: @escaping (DragonResult<[Dragon]>) -> Void) {

        let url = "https://demo6649570.mockable.io/dragoslist"
        self.jsonService.request(url) { (result: DragonResult<DragonsListResponse>) in

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
    
}
