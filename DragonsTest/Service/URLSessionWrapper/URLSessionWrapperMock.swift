//
//  URLSessionWrapperMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 09/06/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class URLSessionWrapperMock: URLSessionWrappperProtocol {

    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        receivedUrl = url.absoluteString
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return dataTask
    }
    
    // testing
    var isSuccess = false
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var receivedUrl: String?
    var dataTask = MockURLSessionDataTask()

}

