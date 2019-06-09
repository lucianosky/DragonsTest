//
//  URLSessionWrappperProtocol.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 09/06/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionWrappperProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
