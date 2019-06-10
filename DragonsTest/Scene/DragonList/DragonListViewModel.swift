//
//  DragonListViewModel.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonListViewModel: DragonListViewModelProtocol {
    
    private(set) var dragons: [Dragon] = [Dragon]()
    
    private var dragonModel: DragonModelProtocol

    init(dragonModel: DragonModelProtocol? = nil) {
        self.dragonModel = dragonModel ?? DragonModel()
    }
    
    func getDragons(onCompleted: @escaping (ServiceResult<Bool>) -> Void) {
        self.dragonModel.getDragons { (result) in
            switch(result) {
                
            case .success(let dragons):
                self.dragons = dragons
                onCompleted(.success(true))
                
            case .failure(let error):
                onCompleted(.failure(error))
            }
            
        }
    }

    func dragonSound(for dragon: Dragon) -> String {
        return dragon.greetingType.sound
    }
    
    // TODO - missing test case
    func dragonSound(forDragonInRow row: Int) -> String {
        if dragons.indices.contains(row) {
            let dragon = dragons[row]
            return dragonSound(for: dragon)
        } else {
            // TODO
            return "error"
        }
    }
    
    // TODO - missing test case
    func dragonDescription(forDragonInRow row: Int) -> String {
        if dragons.indices.contains(row) {
            let dragon = dragons[row]
            if let description = dragon.description {
                return description
            } else if let title = dragon.title {
                return title
            } else {
                return dragon.greetingType.sound
            }
        } else {
            // TODO
            return "error"
        }
    }
    
    // TODO - missing test case
    func getDragonImage(forDragonInRow row: Int, onCompleted: @escaping (ServiceResult<Data>) -> Void) {
        if dragons.indices.contains(row) {
            let dragon = dragons[row]
            if let image = dragon.image {
                dragonModel.getDragonImage(url: image) { (result) in
                    onCompleted(result)
                }
            }
        }
        onCompleted(.failure(AppError.viewModelError("error in getDragonImage")))
    }

    
}
