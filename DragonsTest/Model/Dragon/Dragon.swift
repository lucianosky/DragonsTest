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
    let greetingType: GreetingType
    
    init(id: Int, title: String?, description: String?, age: Int?, image: String?, greetingType: GreetingType) {
        self.id = id
        self.title = title
        self.description = description
        self.age = age
        self.image = image
        self.greetingType = greetingType
    }
    
    init(dragonResponse: DragonResponse) {
        self.id = dragonResponse.id
        self.title = dragonResponse.title
        self.description = dragonResponse.description
        self.age = dragonResponse.age
        self.image = dragonResponse.image
        self.greetingType = GreetingType.from(string: dragonResponse.greeting_type ?? GreetingType.defaultString)
    }
    
    static func listFromResponse(_ response: [DragonResponse]) -> [Dragon] {
        return response.map(Dragon.init)
    }
    
}
