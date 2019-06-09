//
//  GitHubResource.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol GitHubResource {
    var url: URL { get }
}

let organisationsURL = URL(staticString: "https://api.github.com/orgs/")

var organisationRepositoriesURL: (String) -> URL? = { organisation in
    return URL(string: organisation + "/repos", relativeTo: organisationsURL)
}
