//
//  OrganisationSearchResultsRouter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol OrganisationSearchRouting {
    /// If the Organisation Search scene is wrapped in a navigation controller, routes to Repository Search Results scene
    func routeToRepositorySearchResults(for organisation: Organisation)
}

final class OrganisationSearchRouter: OrganisationSearchRouting {
    
    // MARK: - Dependencies
    
    weak var sourceViewController: UIViewController?
    let wireframe: Wireframe
    let scenePresenter: ScenePresenting
    
    // MARK: - Lifecycle
    
    init(sourceViewController: UIViewController, scenePresenter: ScenePresenting, wireframe: Wireframe) {
        self.sourceViewController = sourceViewController
        self.wireframe = wireframe
        self.scenePresenter = scenePresenter
    }
    
    // MARK: - OrganisationSearchResultsRouting
    
    func routeToRepositorySearchResults(for organisation: Organisation) {
        executeOnMain(target: self) { router in
            guard let navigationController = router.sourceViewController?.navigationController else {
                return
            }
            
            let repositorySearchScene = router.wireframe.repositorySearchScene(organisation: organisation)
            router.scenePresenter.pushViewController(for: repositorySearchScene, to: navigationController)
        }
    }
}
