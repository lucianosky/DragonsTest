//
//  DragonModelMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class DragonModelMock: DragonModelProtocol {
    
    // protocol

    func getDragons(onCompleted: @escaping (DragonResult<[Dragon]>) -> Void) {
        if isSuccess {
            onCompleted(.success(TextFileHelper.DragonList()))
        } else {
            onCompleted(.failure(DragonError.modelError("getDragons")))
        }
    }
    
    // testing
    var isSuccess = false

}
