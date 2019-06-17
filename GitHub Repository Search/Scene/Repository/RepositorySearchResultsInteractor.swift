//
//  RepositorySearchResultsInteractor.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol RepositorySearchResultsInteracting {

    /// Retrieves a list of repositories for the given organisation and forwards it to the presenter to format for display
    func loadOrganisationRepositories()
    
    /// Processes the selection of the repository at the given array index
    /// - parameter index: the index of the selected repository
    func selectResult(at index: Int)
}

final class RepositorySearchResultsInteractor: RepositorySearchResultsInteracting {
    
    // MARK: - Dependencies
    
    let service: GitHubSiteServing
    let presenter: RepositorySearchResultsPresenting
    let router: RepositorySearchResultsRouting
    
    // MARK: - Properties
    
    /// The organisation that owns the repositories that will be searched for and presented
let organisation: Organisation
    
    // MARK: - Lifecycle
    
    init(organisation: Organisation, service: GitHubSiteServing, presenter: RepositorySearchResultsPresenting, router: RepositorySearchResultsRouting) {
        self.organisation = organisation
        self.service = service
        self.presenter = presenter
        self.router = router
    }
    
    // MARK: - RepositorySearchResultsInteracting
    
    func loadOrganisationRepositories() {
        service.fetchRepositories(for: organisation, refresh: false, completionHandler: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(repositories):
                self.organisation.repositories = repositories
                self.presenter.presentRepositories(repositories)
            case let .failure(error):
                self.organisation.repositories = []
                self.presenter.presentError(error)
            }
        })
    }
    
    func selectResult(at index: Int) {
        #warning("Force unwrapped optional: please rework this")
        router.routeToURL(organisation.repositories![index].htmlURL)
    }
}
