//
//  Repository.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// Maps to the GitHub API's response structure describing a repository
struct Repository: Codable, Equatable {
    /// The name of the repository
    let name: String
    
    /// A `URL` pointing to the human-readable view of the repository
    let htmlURL: URL
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case name
        case htmlURL = "html_url"
    }
}
