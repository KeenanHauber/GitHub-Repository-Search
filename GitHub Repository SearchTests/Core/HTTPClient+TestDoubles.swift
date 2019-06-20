//
//  HTTPClient+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 20/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

final class HTTPClientSpy: HTTPClient {
    var result: Result<Data, HTTPRequestError>
    private(set) var parametersFor_fetchData: [(url: URL, completionHandler: ((Result<Data, HTTPRequestError>) -> Void)?)] = []
    
    init(result: Result<Data, HTTPRequestError>) {
        self.result = result
    }
    
    func fetchData(from url: URL, completionHandler: @escaping (Result<Data, HTTPRequestError>) -> Void) {
        self.parametersFor_fetchData.append((url, completionHandler))
        completionHandler(result)
    }
}
