//
//  DragonModelMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonModelMock: DragonModelProtocol {
    
    func getDragons(onCompleted: @escaping (DragonResult<[Dragon]>) -> Void) {
    }
    
}
