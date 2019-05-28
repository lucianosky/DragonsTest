//
//  DragonModelTests.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Quick
import Nimble

@testable import DragonsTest

class DragonModelTests: QuickSpec {
    
    override func spec() {
        
        var dragonModel: DragonModel!
        var jsonServiceMock: JSONServiceMock!
        var receivedSignal: Bool!
        var receivedDragons: [Dragon]!
        var receivedError: Error!
        let fullURL = "\(PListHelper.baseURL)/dragoslist"
        
        describe("JSONService") {
            
            func performGetDragons(_ isSuccess: Bool, onCompleted: @escaping () -> Void) {
                jsonServiceMock.isSuccess = isSuccess
                jsonServiceMock.successObject = isSuccess ? TextFileHelper.DragonListAsJSON() : nil
                
                dragonModel.getDragons(onCompleted: { (result) in
                    receivedSignal = true
                    switch(result) {
                    case .success(let dragons):
                        receivedDragons = dragons
                    case .failure(let error):
                        receivedError = error
                    }
                    onCompleted()
                })
            }
            
            beforeEach {
                jsonServiceMock = JSONServiceMock()
                dragonModel = DragonModel(jsonService: jsonServiceMock)
                receivedSignal = false
                receivedDragons = nil
                receivedError = nil
            }
            
            context("When performin getDragons with success") {
                it("it should return a dragon list" ) {
                    waitUntil{ done in
                        performGetDragons(true){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragons.count).to(equal(10))
                    expect(jsonServiceMock.receivedUrl).to(equal(fullURL))
                }
            }

            context("When performin request with failure") {
                it("it should return an error" ) {
                    waitUntil{ done in
                        performGetDragons(false){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragons).to(beNil())
                    expect(jsonServiceMock.receivedUrl).to(equal(fullURL))
                    expect(receivedError?.associatedMessage).to(equal("modelError"))
                }
            }

        }
    }
}
