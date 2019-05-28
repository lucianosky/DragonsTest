//
//  Dragon.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

struct Dragon {
    let id: Int
    let title: String?
    let description: String?
    let age: Int?
    let image: String?
    let greeting_type: String?
    
    init(dragonResponse: DragonResponse) {
        self.id = dragonResponse.id
        self.title = dragonResponse.title
        self.description = dragonResponse.description
        self.age = dragonResponse.age
        self.image = dragonResponse.image
        self.greeting_type = dragonResponse.greeting_type
    }
    
    static func listFromResponse(_ response: [DragonResponse]) -> [Dragon] {
        return response.map(Dragon.init)
    }
    
}
