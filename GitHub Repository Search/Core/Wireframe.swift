//
//  Wireframe.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// A dependency injection helper object that constructs scenes, re-using dependencies
final class Wireframe {
    
    // MARK: - Dependencies
    
    private let gitHubSiteService: GitHubSiteService
    
    // MARK: - Lifecycle
    
    init(gitHubSiteService: GitHubSiteService) {
        self.gitHubSiteService = gitHubSiteService
    }
    
    // MARK: - Builders
    
    func organisationSearchScene() -> OrganisationSearchScene {
        return OrganisationSearchScene(gitHubSiteService: gitHubSiteService, wireframe: self)
    }
    
    func repositorySearchScene(organisation: Organisation) -> RepositorySearchResultsScene {
        return RepositorySearchResultsScene(organisation: organisation, gitHubSiteService: gitHubSiteService, wireframe: self)
    }
}
