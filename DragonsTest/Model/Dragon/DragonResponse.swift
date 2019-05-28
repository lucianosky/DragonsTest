//
//  DragonResponse.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

struct DragonResponse: Decodable {
    let id: Int
    let title: String?
    let description: String?
    let age: Int?
    let image: String?
    let greeting_type: String?
}
