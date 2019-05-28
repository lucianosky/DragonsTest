//
//  JSONServiceTests.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Quick
import Nimble

@testable import DragonsTest

private enum RequestResult {
    case isSuccess
    case isFailure
    case isError
}

class JSONServiceTests: QuickSpec {
    
    override func spec() {
        
        var jsonService: JSONService!
        var dataServiceMock: DataServiceMock!
        var receivedSignal: Bool!
        var receivedDragon: DragonResponse!
        var receivedError: Error!
        let dragonUrl = "dragonUrl"

        describe("JSONService") {

            func performRequest(_ requestResult: RequestResult, onCompleted: @escaping () -> Void) {
                switch requestResult {
                case .isSuccess:
                    dataServiceMock.setDragonResult()
                case .isFailure:
                    break
                case .isError:
                    dataServiceMock.setNotADragonResult()
                }
                jsonService.request(dragonUrl, onCompleted: { (result: DragonResult<DragonResponse>) in
                    receivedSignal = true
                    switch(result) {
                    case .success(let dragon):
                        receivedDragon = dragon
                    case .failure(let error):
                        receivedError = error
                    }
                    onCompleted()
                })
            }
            
            beforeEach {
                dataServiceMock = DataServiceMock()
                jsonService = JSONService(dataService: dataServiceMock)
                receivedSignal = false
                receivedDragon = nil
                receivedError = nil
            }
            
            context("When performing request with success") {
                it("it should return a dragon" ) {
                    waitUntil{ done in
                        performRequest(.isSuccess){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragon.age).to(equal(3434))
                    expect(dataServiceMock.receivedUrl).to(equal(dragonUrl))
                }
            }

            context("When performing request with failure") {
                it("it should return an error" ) {
                    waitUntil{ done in
                        performRequest(.isFailure){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragon).to(beNil())
                    expect(dataServiceMock.receivedUrl).to(equal(dragonUrl))
                    expect(receivedError?.associatedMessage).to(equal("request"))
                }
            }

            context("When performing request with parsing error") {
                it("it should return an error from decodable" ) {
                    waitUntil{ done in
                        performRequest(.isError){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedDragon).to(beNil())
                    expect(dataServiceMock.receivedUrl).to(equal(dragonUrl))
                    expect(receivedError?.associatedMessage).to(equal("The data couldn’t be read because it is missing."))
                }
            }
        }
    }
}
