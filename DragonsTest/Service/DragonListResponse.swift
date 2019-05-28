//
//  DragonListResponse.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

struct DragonsListResponse: Decodable {
    let success: Bool
    let dragons: [DragonResponse?]
}

struct DragonResponse: Decodable {
    let id: Int
    let title: String?
    let description: String?
    let age: Int?
    let image: String?
    let greeting_type: String?
}

