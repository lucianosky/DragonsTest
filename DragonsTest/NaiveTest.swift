//
//  NaiveTest.swift
//  DragonsTestTests
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Quick
import Nimble

@testable import DragonsTest

class NaiveTest: QuickSpec {
    
    override func spec() {
        
        describe("NaiveTest") {
            
            context("when performing a naive test") {
                it("it should always pass" ) {
                    expect(true).to(beTrue())
                }
            }
        }
    }
}
