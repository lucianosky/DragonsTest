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
        var dataServiceMock: DataServiceMock!
        var receivedSignal: Bool!
        var receivedDragons: [Dragon]!
        var receivedError: Error!
        let fullURL = "\(PListHelper.baseURL)/dragoslist"
        let dragonURL = "dragonURL"
        
        describe("DragonModelTests") {
            
            func performGetDragons(_ isSuccess: Bool, onCompleted: @escaping () -> Void) {
                dataServiceMock.isSuccess = isSuccess
                dataServiceMock.successObject = isSuccess ? TextFileHelper.DragonListAsJSON() : nil
                
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
            
            func performGetDragonImage(_ isSuccess: Bool, onCompleted: @escaping () -> Void) {
                dataServiceMock.isSuccess = isSuccess
                dataServiceMock.data = TextFileHelper.DragonAsData()

                dragonModel.getDragonImage(url: dragonURL, onCompleted: { (result) in
                    receivedSignal = true
                    onCompleted()
                })
            }
            
            beforeEach {
                dataServiceMock = DataServiceMock()
                dragonModel = DragonModel(dataService: dataServiceMock)
                receivedSignal = false
                receivedDragons = nil
                receivedError = nil
            }
            
            context("When performing getDragons with success") {
                it("it should return a dragon list" ) {
                    waitUntil{ done in
                        performGetDragons(true){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragons.count).to(equal(12))
                    expect(dataServiceMock.receivedUrl).to(equal(fullURL))
                }
            }

            context("When performing getDragons with failure") {
                it("it should return an error" ) {
                    waitUntil{ done in
                        performGetDragons(false){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragons).to(beNil())
                    expect(dataServiceMock.receivedUrl).to(equal(fullURL))
                    expect(receivedError?.associatedMessage).to(equal("modelError"))
                }
            }

            context("When performing getDragonImage") {
                it("result is not checked" ) {
                    waitUntil{ done in
                        performGetDragonImage(true){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(dataServiceMock.receivedUrl).to(equal(dragonURL))
                }
            }

        }
    }
}
