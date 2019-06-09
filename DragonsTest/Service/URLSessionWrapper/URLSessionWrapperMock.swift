//
//  URLSessionWrapperMock.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 09/06/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

class URLSessionWrapperMock: URLSessionWrappperProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
}
