//
//  Organisation.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// Maps to the GitHub API's response structure describing an organisation's account, apart from the repositories which are retrieved
/// separately.
///
/// TODO: - remove the `repositories` property from the data layer's model, since it isn't included in the GitHub API data structure
struct Organisation: Decodable, Equatable {
    /// The name of the organisation
    let name: String
    
    /// The repositories associated with the organisation. A nil value indicates that the repositories have not yet been retrieved, while
    /// an empty array indicates no repositories are associated with the organisation
    ///
    /// This value is not decoded from the
    var repositories: [Repository]?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
