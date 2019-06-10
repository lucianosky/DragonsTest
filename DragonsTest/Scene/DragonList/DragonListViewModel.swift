//
//  DragonListViewModel.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

private struct Consts {
    static let missingDragonDescription = "Missing dragonDescription"
    static let missingDragonSound = "Missing dragonSound"
    static let errorInGetDragonImage = "Error in getDragonImage"
}


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
    
    func dragonSound(forDragonInRow row: Int) -> String {
        if dragons.indices.contains(row) {
            return dragons[row].greetingType.sound
        }
        LogHelper.shared.warning(Consts.missingDragonSound)
        return Consts.missingDragonSound
    }
    
    func dragonDescription(forDragonInRow row: Int) -> String {
        if dragons.indices.contains(row) {
            return dragons[row].getDescriptionText()
        }
        LogHelper.shared.warning(Consts.missingDragonDescription)
        return Consts.missingDragonDescription
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
        onCompleted(.failure(AppError.viewModelError(Consts.errorInGetDragonImage)))
    }

    
}
