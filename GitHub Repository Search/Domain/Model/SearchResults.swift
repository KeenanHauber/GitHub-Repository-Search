//
//  SearchResults.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

struct SearchResults<ItemType: Decodable>: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    
    let items: [ItemType]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        
        case items
    }
}
