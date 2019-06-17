//
//  OrganisationSearchResultsRouter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol OrganisationSearchRouting {
    func routeToRepositorySearchResults(for organisation: Organisation)
}

final class OrganisationSearchRouter: OrganisationSearchRouting {
    
    // MARK: - Dependencies
    
    weak var sourceViewController: UIViewController?
    let wireframe: Wireframe
    
    // MARK: - Lifecycle
    
    init(sourceViewController: UIViewController, wireframe: Wireframe) {
        self.sourceViewController = sourceViewController
        self.wireframe = wireframe
    }
    
    // MARK: - OrganisationSearchResultsRouting
    
    func routeToRepositorySearchResults(for organisation: Organisation) {
        #warning("untested code")
        executeOnMain(target: self) { router in
            guard let navigationController = router.sourceViewController?.navigationController else {
                return
            }
            
            let repositorySearchViewController = router.wireframe.repositorySearchScene(organisation: organisation).build()
            navigationController.pushViewController(repositorySearchViewController, animated: true)
        }
    }
}
