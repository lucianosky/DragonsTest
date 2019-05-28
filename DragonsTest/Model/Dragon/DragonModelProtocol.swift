//
//  DragonModelProtocol.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol DragonModelProtocol {
    func getDragons(onCompleted: @escaping (DragonResult<[Dragon]>) -> Void)
}
