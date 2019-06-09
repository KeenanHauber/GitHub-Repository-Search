//
//  RepositorySearchResultsRouter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 10/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import UIKit

protocol RepositorySearchResultsRouting {}

final class RepositorySearchResultsRouter: RepositorySearchResultsRouting {
    
    // MARK: - Dependencies
    
    private weak var sourceViewController: UIViewController?
    
    // MARK: - Lifecycle
    
    init(sourceViewController: UIViewController) {
        self.sourceViewController = sourceViewController
    }
    
    // MARK: - RepositorySearchResultsRouting
}
