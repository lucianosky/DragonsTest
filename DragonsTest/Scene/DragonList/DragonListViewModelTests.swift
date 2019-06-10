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
            
            func expectedSound(greetingType: GreetingType) -> String {
                switch greetingType {
                case .whoa: return "Whoaaaaaaa"
                case .groar: return "Groarrrrrrr!"
                case .roar: return "Roarrrrrrrr!"
                case .gr: return "Grrrrrrrrrrr!"
                }
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
            
            context("When performing dragonSound for existing row") {
                it("it should return a sound" ) {
                    waitUntil{ done in
                        performGetDragons(true){
                            done()
                        }
                    }
                    let sound = dragonListViewModel.dragonSound(forDragonInRow: 0)
                    expect(sound).to(equal("Whoaaaaaaa"))
                    let soundError = dragonListViewModel.dragonSound(forDragonInRow: -1)
                    expect(soundError).to(equal("Missing dragonSound"))
                }
            }

            context("When performing dragonDescription for existing row") {
                it("it should return dragon's getDescriptionText()" ) {
                    waitUntil{ done in
                        performGetDragons(true){
                            done()
                        }
                    }
                    let descriptionDescr = dragonListViewModel.dragonDescription(forDragonInRow: 0)
                    expect(descriptionDescr).to(equal("A beautiful japanese dragon."))
 
                    let descriptionTitle = dragonListViewModel.dragonDescription(forDragonInRow: 10)
                    expect(descriptionTitle).to(equal("Just a title"))
                    
                    let descriptionSound = dragonListViewModel.dragonDescription(forDragonInRow: 11)
                    expect(descriptionSound).to(equal("Grrrrrrrrrrr!"))
                    
                    let descriptionError = dragonListViewModel.dragonDescription(forDragonInRow: -1)
                    expect(descriptionError).to(equal("Missing dragonDescription"))
                }
            }

            for greetingType in GreetingType.allCases {
                context("when dragon greeting type is \(greetingType)") {
                    let expected = expectedSound(greetingType: greetingType)
                    it("then the sound should be \(expected)") {
                        let dragon = Dragon.init(id: 1, title: nil, description: nil, age: nil, image: nil, greetingType: greetingType)
                        let sound = dragonListViewModel.dragonSound(for: dragon)
                        expect(sound).to(equal(expected))
                    }
                }
            }

            
        }
    }
}
