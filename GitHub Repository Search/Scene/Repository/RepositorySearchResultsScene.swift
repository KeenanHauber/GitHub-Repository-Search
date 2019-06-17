//
//  RepositorySearchResultsScene.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

final class RepositorySearchResultsScene: Scene {
    
    // MARK: - Dependencies
    
    let gitHubSiteService: GitHubSiteServing
    let organisation: Organisation
    let wireframe: Wireframe
    let urlOpener: URLOpening
    
    // MARK: - Lifecycle
    
    init(organisation: Organisation, gitHubSiteService: GitHubSiteServing, wireframe: Wireframe, urlOpener: URLOpening) {
        self.gitHubSiteService = gitHubSiteService
        self.organisation = organisation
        self.wireframe = wireframe
        self.urlOpener = urlOpener
    }
    
    // MARK: - Scene
    
    /// Constructs the repository search results scene and returns its view controller so it may be presented
    func build() -> UIViewController {
        let viewController = RepositorySearchResultsViewController()
        let presenter = RepositorySearchResultsPresenter(display: viewController)
        let router = RepositorySearchResultsRouter(urlOpener: UIApplication.shared)
        viewController.interactor = RepositorySearchResultsInteractor(organisation: organisation, service: gitHubSiteService, presenter: presenter, router: router)
        return viewController
    }
}
