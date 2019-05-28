//
//  DragonListViewModelMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonListViewModelMock: DragonListViewModelProtocol {
    var dragons: [Dragon] = [Dragon]()
    
    func getDragons(onCompleted: @escaping (DragonResult<Bool>) -> Void) {
    }
    
    func dragonSound(for dragon: Dragon) -> String {
        return "dragonSound"
    }
    
    func dragonDescription(forDragonInRow row: Int) -> String {
        return "dragonDescription"
    }
    
    func getDragonImage(forDragonInRow row: Int, onCompleted: @escaping (DragonResult<Data>) -> Void) {
    }

}
