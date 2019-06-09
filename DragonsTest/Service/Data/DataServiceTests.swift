//
//  DataServiceTests.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Quick
import Nimble

@testable import DragonsTest

class DataServiceTests: QuickSpec {
    
    override func spec() {
        
        var dataService: DataService!
        var urlSessionWrapperMock: URLSessionWrapperMock!
        var receivedSignal: Bool!
        var receivedData: Data!
        var receivedError: Error!
        let requestUrl = "requestUrl"
        let someData = TextFileHelper.DragonAsData()
        let performRequestError = "performRequestError"

        describe("DataService") {

            func performRequest(_ isSuccess: Bool, urlString: String, data: Data?, statusCode: Int, onCompleted: @escaping () -> Void) {
                urlSessionWrapperMock.isSuccess = isSuccess
                if isSuccess {
                    urlSessionWrapperMock.data = data
                } else {
                    urlSessionWrapperMock.error = DragonError.dataError(performRequestError)
                }
                urlSessionWrapperMock.urlResponse = HTTPURLResponse(url: URL(string: requestUrl)!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
                dataService.request(urlString, onCompleted: { (result: DragonResult<Data>) in
                    receivedSignal = true
                    switch(result) {
                    case .success(let data):
                        receivedData = data
                    case .failure(let error):
                        receivedError = error
                    }
                    onCompleted()
                })
            }

            beforeEach {
                urlSessionWrapperMock = URLSessionWrapperMock()
                dataService = DataService(urlSessionWrappper: urlSessionWrapperMock)
                receivedSignal = false
                receivedData = nil
                receivedError = nil
            }

            context("When performing request with success") {
                it("it should return data" ) {
                    waitUntil{ done in
                        performRequest(true, urlString: requestUrl, data: someData, statusCode: 200){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedData).to(equal(someData))
                    expect(receivedError).to(beNil())
                    expect(urlSessionWrapperMock.receivedUrl).to(equal(requestUrl))
                    expect(urlSessionWrapperMock.dataTask.resumeWasCalled).to(beTrue())
                }
            }

            context("When performing request with URL error") {
                it("it should return Error creating URL" ) {
                    waitUntil{ done in
                        performRequest(true, urlString: "", data: someData, statusCode: 200){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedData).to(beNil())
                    expect(receivedError.associatedMessage).to(equal("Error creating URL"))
                    expect(urlSessionWrapperMock.receivedUrl).to(beNil())
                    expect(urlSessionWrapperMock.dataTask.resumeWasCalled).to(beFalse())
                }
            }
            
            context("When performing request with error") {
                it("it should return performRequestError" ) {
                    waitUntil{ done in
                        performRequest(false, urlString: requestUrl, data: nil, statusCode: 200){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedData).to(beNil())
                    expect(receivedError.associatedMessage).to(equal(performRequestError))
                    expect(urlSessionWrapperMock.receivedUrl).to(equal(requestUrl))
                    expect(urlSessionWrapperMock.dataTask.resumeWasCalled).to(beTrue())
                }
            }
            
            context("When performing request with statusCode error") {
                it("it should return Error parsing response" ) {
                    waitUntil{ done in
                        performRequest(true, urlString: requestUrl, data: someData, statusCode: 404){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedData).to(beNil())
                    expect(receivedError.associatedMessage).to(equal("Error parsing response"))
                    expect(urlSessionWrapperMock.receivedUrl).to(equal(requestUrl))
                    expect(urlSessionWrapperMock.dataTask.resumeWasCalled).to(beTrue())
                }
            }
        }
    }
}
