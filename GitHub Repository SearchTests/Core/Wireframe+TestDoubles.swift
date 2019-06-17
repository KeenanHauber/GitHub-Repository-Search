//
//  Wireframe+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

final class WireframeDummy: Wireframe {
    func organisationSearchScene() -> OrganisationSearchScene {
        return OrganisationSearchScene(
            gitHubSiteService: GitHubSiteServiceDummy(),
            wireframe: self,
            scenePresenter: ScenePresentingDummy()
        )
    }
    
    func repositorySearchScene(organisation: Organisation) -> RepositorySearchResultsScene {
        return RepositorySearchResultsScene(
            organisation: organisation,
            gitHubSiteService: GitHubSiteServiceDummy(),
            wireframe: self,
            urlOpener: URLOpeningDummy()
        )
    }
}

final class WireframeSpy: Wireframe {
    private let repositorySearchResultsScene: RepositorySearchResultsScene
    
    init(repositorySearchResultsScene: RepositorySearchResultsScene) {
        self.repositorySearchResultsScene = repositorySearchResultsScene
    }
    
    private(set) var timesCalled_organisationSearchScene: Int = 0
    func organisationSearchScene() -> OrganisationSearchScene {
        timesCalled_organisationSearchScene += 1
        return OrganisationSearchScene(
            gitHubSiteService: GitHubSiteServiceDummy(),
            wireframe: self,
            scenePresenter: ScenePresentingDummy()
        )
    }
    
    private(set) var parametersFor_repositorySearchScene: [Organisation] = []
    
    func repositorySearchScene(organisation: Organisation) -> RepositorySearchResultsScene {
        
        parametersFor_repositorySearchScene.append(organisation)
        
        return repositorySearchResultsScene
    }
}
