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

        describe("DataService") {

            func performRequest(_ isSuccess: Bool, data: Data?, statusCode: Int, onCompleted: @escaping () -> Void) {
                urlSessionWrapperMock.isSuccess = isSuccess
                urlSessionWrapperMock.data = data
                urlSessionWrapperMock.urlResponse = HTTPURLResponse(url: URL(string: requestUrl)!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
                dataService.request(requestUrl, onCompleted: { (result: DragonResult<Data>) in
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
                        performRequest(true, data: someData, statusCode: 200){
                            done()
                        }
                    }
                    expect(receivedSignal).to(beTrue())
                    expect(receivedData).to(equal(someData))
                    expect(urlSessionWrapperMock.receivedUrl).to(equal(requestUrl))
                    expect(urlSessionWrapperMock.dataTask.resumeWasCalled).to(beTrue())
                }
            }

        }
    }
}
