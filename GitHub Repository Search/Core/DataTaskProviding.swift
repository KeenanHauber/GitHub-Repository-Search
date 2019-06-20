//
//  DataTaskProviding.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 20/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol DataTaskProviding {
    /// Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: DataTaskProviding {}
