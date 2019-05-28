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
    
    func getDragons(onCompleted: @escaping (DragonResult<Bool>) -> Void) {
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
    
}
