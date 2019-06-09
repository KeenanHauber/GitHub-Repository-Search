//
//  RepositorySearchResultsInteractor.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
#warning("Interactor should not depend on UIKit")
import UIKit

protocol RepositorySearchResultsInteracting {
    func loadResults()
    func selectResult(at index: Int)
}

final class RepositorySearchResultsInteractor: RepositorySearchResultsInteracting {
    
    // MARK: - Dependencies
    
    private let service: GitHubSiteServing
    private let presenter: RepositorySearchResultsPresenting
    
    // MARK: - Properties
    
    private var repositories: [Repository] = []
    
    // MARK: - Lifecycle
    
    init(service: GitHubSiteServing, presenter: RepositorySearchResultsPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    // MARK: - RepositorySearchResultsInteracting
    
    func loadResults() {
        service.fetchRepositories(forOrganisationNamed: "spring", completionHandler: { result in
            DispatchQueue.main.sync {
                switch result {
                case let .success(repositories):
                    self.repositories = repositories
                    self.presenter.presentRepositories(repositories)
                case let .failure(error):
                    self.repositories = []
                    self.presenter.presentError(error)
                }
            }
        })
    }
    
    func selectResult(at index: Int) {
        UIApplication.shared.open(repositories[index].htmlURL)
    }
}
