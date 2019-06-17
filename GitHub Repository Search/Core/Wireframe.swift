//
//  Wireframe.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol Wireframe {
    func organisationSearchScene() -> OrganisationSearchScene
    func repositorySearchScene(organisation: Organisation) -> RepositorySearchResultsScene
}

/// A dependency injection helper object that constructs scenes, re-using dependencies
final class DefaultWireframe: Wireframe {
    
    // MARK: - Dependencies
    
    let gitHubSiteService: GitHubSiteServing
    let urlOpener: URLOpening
    let scenePresenter: ScenePresenting
    
    // MARK: - Lifecycle
    
    init(gitHubSiteService: GitHubSiteServing, urlOpener: URLOpening, scenePresenter: ScenePresenting) {
        self.gitHubSiteService = gitHubSiteService
        self.urlOpener = urlOpener
        self.scenePresenter = scenePresenter
    }
    
    // MARK: - Builders
    
    func organisationSearchScene() -> OrganisationSearchScene {
        return OrganisationSearchScene(gitHubSiteService: gitHubSiteService, wireframe: self, scenePresenter: scenePresenter)
    }
    
    func repositorySearchScene(organisation: Organisation) -> RepositorySearchResultsScene {
        return RepositorySearchResultsScene(organisation: organisation, gitHubSiteService: gitHubSiteService, wireframe: self, urlOpener: urlOpener)
    }
}
