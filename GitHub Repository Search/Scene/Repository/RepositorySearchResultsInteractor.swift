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
    
    private let service: GitHubSiteServing
    private let presenter: RepositorySearchResultsPresenting
    private let router: RepositorySearchResultsRouting
    
    // MARK: - Properties
    
    /// The organisation that owns the repositories that will be searched for and presented
    private let organisation: Organisation
    /// Cached repositories from the previous fetch
    private var repositories: [Repository] = []
    
    // MARK: - Lifecycle
    
    init(organisation: Organisation, service: GitHubSiteServing, presenter: RepositorySearchResultsPresenting, router: RepositorySearchResultsRouting) {
        self.organisation = organisation
        self.service = service
        self.presenter = presenter
        self.router = router
    }
    
    // MARK: - RepositorySearchResultsInteracting
    
    func loadOrganisationRepositories() {
        service.fetchRepositories(forOrganisationNamed: organisation.name, completionHandler: { result in
            switch result {
            case let .success(repositories):
                self.repositories = repositories
                self.presenter.presentRepositories(repositories)
            case let .failure(error):
                self.repositories = []
                self.presenter.presentError(error)
            }
        })
    }
    
    func selectResult(at index: Int) {
        router.routeToURL(repositories[index].htmlURL)
    }
}
