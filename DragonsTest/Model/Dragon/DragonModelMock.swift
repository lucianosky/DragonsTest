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

    func getDragons(onCompleted: @escaping (ServiceResult<[Dragon]>) -> Void) {
        if isSuccess {
            onCompleted(.success(TextFileHelper.DragonList()))
        } else {
            onCompleted(.failure(AppError.modelError("getDragons")))
        }
    }
    
    func getDragonImage(url: String, onCompleted: @escaping (ServiceResult<Data>) -> Void) {
    }

    // testing
    var isSuccess = false

}
