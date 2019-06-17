//
//  OrganisationSearchScene.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

final class OrganisationSearchScene: Scene {
    
    // MARK: - Dependencies
    
    let gitHubSiteService: GitHubSiteServing
    let wireframe: Wireframe
    let scenePresenter: ScenePresenting
    
    // MARK: - Lifecycle
    
    init(gitHubSiteService: GitHubSiteServing, wireframe: Wireframe, scenePresenter: ScenePresenting) {
        self.gitHubSiteService = gitHubSiteService
        self.wireframe = wireframe
        self.scenePresenter = scenePresenter
    }
    
    // MARK: - Scene
    
    /// Constructs the organisation search scene and returns its view controller so it may be presented
    func build() -> UIViewController {
        let viewController = OrganisationSearchViewController()
        let presenter = OrganisationSearchPresenter(display: viewController)
        let router = OrganisationSearchRouter(sourceViewController: viewController, scenePresenter: scenePresenter, wireframe: wireframe)
        let interactor = OrganisationSearchInteractor(presenter: presenter, router: router, gitHubSiteService: gitHubSiteService)
        viewController.interactor = interactor
        return viewController
    }
}
