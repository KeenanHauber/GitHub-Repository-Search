//
//  HTTPClient.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 20/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func fetchData(from url: URL, completionHandler: @escaping (Result<Data, HTTPRequestError>) -> Void)
}

final class Something: HTTPClient {
    let dataTaskProvider: DataTaskProviding
    
    init(dataTaskProvider: DataTaskProviding = URLSession.shared) {
        self.dataTaskProvider = dataTaskProvider
    }
    
    func fetchData(from url: URL, completionHandler: @escaping (Result<Data, HTTPRequestError>) -> Void) {
        let task = dataTaskProvider.dataTask(with: url) {(data, response, error) in
            if let error = error {
                // data & response will be are invalid, so they don't have to be checked
                completionHandler(.failure(.urlSessionError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else  {
                // this should never happen; `URLSession.shared.dataTask(with:)` always returns an instance `HTTPURLResponse` for the value of `response`
                return
            }
            
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    completionHandler(.failure(.noData))
                    return
                }
                completionHandler(.success(data))
            case 404:
                completionHandler(.failure(.notFound))
            default:
                print("Unknown response code: \(response.statusCode)")
            }
        }
        
        // Trigger the fetch
        task.resume()
    }
}
