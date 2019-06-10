//
//  RepositorySearchResultsRouter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol RepositorySearchResultsRouting {
    func routeToURL(_ url: URL)
}

/// Default router for the RepositorySearchResultsScene.
final class RepositorySearchResultsRouter: RepositorySearchResultsRouting {
    
    // MARK: - Dependencies
    
    private weak var sourceViewController: UIViewController?
    
    // MARK: - Lifecycle
    
    init(sourceViewController: UIViewController) {
        self.sourceViewController = sourceViewController
    }
    
    // MARK: - RepositorySearchResultsRouting
    
    /// Opens the given url.
    ///
    /// - parameter url: the url to be opened
    ///
    /// Although this function could be handled in the view controller, passing the notification through the interactor through to the router
    /// allows urls to be opened in a single location and to be dependent on domain-level logic executed in the interactor. It also allows
    /// simplified analytics, since all analytics recording can be triggered by events in the interactor.
    func routeToURL(_ url: URL) {
        executeOnMain(target: self) { _ in
            // This can be abstracted out for the sake of testing.
            UIApplication.shared.open(url)
        }
    }
}
