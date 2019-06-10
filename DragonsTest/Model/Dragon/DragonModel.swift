//
//  DragonModel.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonModel: DragonModelProtocol {
    
    private var dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol? = nil) {
        self.dataService = dataService ?? DataService()
    }

    func getDragons(onCompleted: @escaping (ServiceResult<[Dragon]>) -> Void) {
        let fullURL = "\(PListHelper.baseURL)/dragoslist"
        dataService.jsonRequest(fullURL) { (result: ServiceResult<DragonsListResponse>) in
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
    func getDragonImage(url: String, onCompleted: @escaping (ServiceResult<Data>) -> Void) {
        dataService.request(url) { (result) in
            onCompleted(result)
        }
    }
    
}
