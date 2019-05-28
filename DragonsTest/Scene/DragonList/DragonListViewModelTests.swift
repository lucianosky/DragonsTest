//
//  DragonListViewModelTests.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Quick
import Nimble

@testable import DragonsTest

class DragonListViewModelTests: QuickSpec {
    
    override func spec() {
        
        var dragonListViewModel: DragonListViewModel!
        var dragonModelMock: DragonModelMock!
        var receivedSignal: Bool!
        var receivedOk: Bool!
        var receivedError: Error!
        
        describe("DragonListViewModelTests") {
            
            func performGetDragons(_ isSuccess: Bool, onCompleted: @escaping () -> Void) {
                dragonModelMock.isSuccess = isSuccess
                
                dragonListViewModel.getDragons(onCompleted: { (result) in
                    receivedSignal = true
                    switch(result) {
                    case .success(let ok):
                        receivedOk = ok
                    case .failure(let error):
                        receivedError = error
                    }
                    onCompleted()
                })
            }
            
            beforeEach {
                dragonModelMock = DragonModelMock()
                dragonListViewModel = DragonListViewModel(dragonModel: dragonModelMock)
                receivedSignal = false
                receivedOk = nil
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
                    expect(receivedOk).to(beTrue())
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
                    expect(receivedOk).to(beNil())
                    expect(receivedError?.associatedMessage).to(equal("getDragons"))
                }
            }
            
        }
    }
}
