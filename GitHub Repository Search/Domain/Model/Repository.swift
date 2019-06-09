//
//  Repository.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let name: String
    
    let url: URL
    let htmlURL: URL
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case name
        
        case url
        case htmlURL = "html_url"
    }
}
