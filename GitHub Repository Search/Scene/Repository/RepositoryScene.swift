//
//  RepositoryScene.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

final class RepositoryScene {
    
    // MARK: - Dependencies
    
    private let gitHubSiteService: GitHubSiteServing
    
    // MARK: - Lifecycle
    
    init(gitHubSiteService: GitHubSiteServing) {
        self.gitHubSiteService = gitHubSiteService
    }
    
    // MARK: - Builder
    
    func build() -> UIViewController {
        let viewController = RepositorySearchViewController()
        let presenter = RepositorySearchResultsPresenter(display: viewController)
        viewController.interactor = RepositorySearchResultsInteractor(service: gitHubSiteService, presenter: presenter)
        return viewController
    }
}
