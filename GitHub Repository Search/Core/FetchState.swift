//
//  FetchState.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// The possible states of an asynchronous data fetch
enum FetchState<Success: Equatable, Failure: Error>: Equatable {
    /// Indicates an in-progress fetch
    case fetching
    /// Indicates a failed fetch
    case failure(Failure)
    /// Indicates a successfully completed fetch
    case success(Success)
    
    // MARK: - Equatable
    
    // equatable conformance for ease of testing
    
    static func == (lhs: FetchState<Success, Failure>, rhs: FetchState<Success, Failure>) -> Bool {
        switch (lhs, rhs) {
        case (.fetching, .fetching):
            return true
        case let (.failure(lhsError), .failure(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.success(lhsSuccess), .success(rhsSuccess)):
            return lhsSuccess == rhsSuccess
        default:
            return false
        }
    }
}
