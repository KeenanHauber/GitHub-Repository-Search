//
//  HTTPRequestError.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 20/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// Possible errors thrown by the `HTTPClient`
enum HTTPRequestError: Error {
    /// Indicates an error within `URLSession.shared.dataTask(with:completionHandler:)`
    case urlSessionError(Error)
    /// Indicates a successful request (code 200) with no data returned
    case noData
    /// Indicates a response code 400
    case badRequest
    /// Indicates a 404 error
    case notFound
}
