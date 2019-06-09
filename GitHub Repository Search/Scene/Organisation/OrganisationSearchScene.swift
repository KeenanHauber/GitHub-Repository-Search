//
//  OrganisationSearchScene.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

final class OrganisationSearchScene {
    
    // MARK: - Dependencies
    
    private let gitHubSiteService: GitHubSiteService
    private let wireframe: Wireframe
    
    // MARK: - Lifecycle
    
    init(gitHubSiteService: GitHubSiteService, wireframe: Wireframe) {
        self.gitHubSiteService = gitHubSiteService
        self.wireframe = wireframe
    }
    
    // MARK: - Builder
    
    func build() -> UIViewController {
        let viewController = OrganisationSearchViewController()
        let presenter = OrganisationSearchPresenter(display: viewController)
        let router = OrganisationSearchRouter(sourceViewController: viewController, wireframe: wireframe)
        let interactor = OrganisationSearchInteractor(presenter: presenter, router: router, gitHubSiteService: gitHubSiteService)
        viewController.interactor = interactor
        return viewController
    }
}
