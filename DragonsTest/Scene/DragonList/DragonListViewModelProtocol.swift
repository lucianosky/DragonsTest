//
//  DragonListViewModelProtocol.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol DragonListViewModelProtocol {
    
    var dragons: [Dragon] {get}
    func getDragons(onCompleted: @escaping (ServiceResult<Bool>) -> Void)
    func dragonSound(for dragon: Dragon) -> String
    func dragonSound(forDragonInRow row: Int) -> String
    func dragonDescription(forDragonInRow row: Int) -> String
    func getDragonImage(forDragonInRow row: Int, onCompleted: @escaping (ServiceResult<Data>) -> Void) 

}
