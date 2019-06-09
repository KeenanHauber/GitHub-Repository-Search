//
//  Organisation.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

struct Organisation: Decodable {
    let name: String
    
    var repositories: [Repository]?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
