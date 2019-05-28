//
//  TextFileHelper.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class TextFileHelper {
    
    private static func contentsOfFileAsString(named name: String) -> String? {
        let testBundle = Bundle(for: TextFileHelper.self)
        if let fileURL = testBundle.url(forResource: name, withExtension: "json") {
            do {
                return try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                return nil
            }
        }
        return nil
    }
    
    static func DragonListAsString() -> String? {
        return TextFileHelper.contentsOfFileAsString(named: "DragonList")
    }
    
    static func DragonListAsData() -> Data? {
        return TextFileHelper.DragonListAsString()?.data(using: .utf8)
    }

    static func DragonListAsJSON() -> DragonsListResponse {
        let data =  TextFileHelper.DragonListAsData()
        let decoder = JSONDecoder()
        return try! decoder.decode(DragonsListResponse.self, from: data!)
    }

    static func DragonAsString() -> String? {
        return TextFileHelper.contentsOfFileAsString(named: "Dragon")
    }
    
    static func DragonAsData() -> Data? {
        return TextFileHelper.DragonAsString()?.data(using: .utf8)
    }
    
    static func NotADragonAsString() -> String? {
        return TextFileHelper.contentsOfFileAsString(named: "NotADragon")
    }
    
    static func NotADragonAsData() -> Data? {
        return TextFileHelper.NotADragonAsString()?.data(using: .utf8)
    }
    
}
