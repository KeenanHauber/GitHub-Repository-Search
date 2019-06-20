//
//  SearchResults.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// Maps to the GitHub API's response to a search query.
///
/// **Note:** This data structure is currently being used by the data & domain layers because
/// this project is currently too small to justify separating the two.
///
/// To keep the Search API fast for everyone, GitHub limits how long any individual query can run. For queries that exceed the time
/// limit, the API returns the matches that were already found prior to the timeout, and the response has the incomplete_results
/// property set to true.
struct SearchResults<ItemType: Codable & Equatable>: Codable, Equatable {
    
    // MARK: - Properties
    
    /// The total number of matches returned by the search. This should correlate to the number of items.
    let totalCount: Int
    
    /// Indicates whether the totalCount
    ///
    /// To keep the Search API fast for everyone, GitHub limits how long any individual query can run. For queries that exceed the time
    /// limit, the API returns the matches that were already found prior to the timeout, and the response has the incomplete_results
    /// property set to true.
    let incompleteResults: Bool
    
    /// The items returned by the search.
    let items: [ItemType]
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        
        case items
    }
}
