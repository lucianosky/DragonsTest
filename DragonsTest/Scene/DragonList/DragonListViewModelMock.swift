//
//  DragonListViewModelMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonListViewModelMock: DragonListViewModelProtocol {
    func getDragons(onCompleted: @escaping (DragonResult<Bool>) -> Void) {
    }
    
    func dragonSound(for dragon: Dragon) -> String {
        return ""
    }
}
