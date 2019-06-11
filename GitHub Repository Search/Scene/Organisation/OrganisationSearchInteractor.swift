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
    func userSelectedOrganisationAt(row: Int)
}

final class OrganisationSearchInteractor: OrganisationSearchInteracting {
    
    // MARK: - Dependencies
    
    let gitHubSiteService: GitHubSiteServing
    let presenter: OrganisationSearchPresenting
    let router: OrganisationSearchRouting
    
    // MARK: - Properties
    
    /// A list of organisations retrieved by the last successful fetch
    private var organisations: [Organisation] = []
    
    // MARK: - Lifecycle
    
    init(presenter: OrganisationSearchPresenting, router: OrganisationSearchRouting, gitHubSiteService: GitHubSiteServing) {
        self.presenter = presenter
        self.gitHubSiteService = gitHubSiteService
        self.router = router
    }
    
    // MARK: - OrganisationSearchInteracting
    
    func searchForOrganisations(named searchTerm: String) {
        presenter.presentFetchState(.fetching)
        
        gitHubSiteService.fetchOrganisations(searchTerm: searchTerm, refresh: false, completionHandler: { result in
            switch result {
            case .success(let organisations):
                self.organisations = organisations
                self.presenter.presentFetchState(.success(organisations))
            case .failure(let error):
                self.presenter.presentFetchState(.failure(error))
            }
        })
    }
    
    func userSelectedOrganisationAt(row: Int) {
        router.routeToRepositorySearchResults(for: organisations[row])
    }
}
