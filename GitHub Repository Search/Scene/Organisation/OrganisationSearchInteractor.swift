//
//  OrganisationSearchInteractor.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol OrganisationSearchInteracting {
    func searchForOrganisations(named searchTerm: String)
    func selectedOrganisationAt(row: Int)
}

final class OrganisationSearchInteractor: OrganisationSearchInteracting {
    
    // MARK: - Dependencies
    
    private let gitHubSiteService: GitHubSiteService
    private let presenter: OrganisationSearchPresenting
    private let router: OrganisationSearchRouting
    
    // MARK: - Properties
    
    /// A list of organisations retrieved by the last successful fetch
    private var organisations: [Organisation] = []
    
    // MARK: - Lifecycle
    
    init(presenter: OrganisationSearchPresenting, router: OrganisationSearchRouting, gitHubSiteService: GitHubSiteService) {
        self.presenter = presenter
        self.gitHubSiteService = gitHubSiteService
        self.router = router
    }
    
    // MARK: - OrganisationSearchInteracting
    
    func searchForOrganisations(named searchTerm: String) {
        gitHubSiteService.fetchOrganisations(searchTerm: searchTerm, refresh: false, completionHandler: { result in
            switch result {
            case .success(let organisations):
                self.organisations = organisations
                self.presenter.presentFetchState(.success)
                self.presenter.presentOrganisations(organisations)
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter.presentFetchState(.failure)
            }
        })
        presenter.presentFetchState(.fetching)
    }
    
    func selectedOrganisationAt(row: Int) {
        router.routeToRepositorySearchResults(for: organisations[row])
    }
}
