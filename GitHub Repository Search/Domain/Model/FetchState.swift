//
//  FetchState.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// The possible states of an asynchronous data fetch
enum FetchState {
    /// Indicates an in-progress fetch
    case fetching
    /// Indicates a failed fetch
    case failure
    /// Indicates a successfully completed fetch
    case success
}
