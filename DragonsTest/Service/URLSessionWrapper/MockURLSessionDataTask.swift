//
//  MockURLSessionDataTask.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 09/06/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
