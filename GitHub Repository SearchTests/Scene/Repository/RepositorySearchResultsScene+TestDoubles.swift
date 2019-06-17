//
//  RepositorySearchResultsScene+TestDoubles.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 13/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

// MARK: - Buildable

extension RepositorySearchResultsInteractor: Buildable {
    static func build(block: (Builder) -> Void) -> RepositorySearchResultsInteractor {
        let builder = Builder()
        block(builder)
        return builder.build()
    }
    
    final class Builder: Builds {
        
        var organisation: Organisation = Organisation(name: "", repositories: [])
        var service: GitHubSiteServing = GitHubSiteServiceDummy()
        var presenter: RepositorySearchResultsPresenting = RepositorySearchResultsPresentingDummy()
        var router: RepositorySearchResultsRouting = RepositorySearchResultsRoutingDummy()
        
        func build() -> RepositorySearchResultsInteractor {
            return RepositorySearchResultsInteractor(
                organisation: organisation,
                service: service,
                presenter: presenter,
                router: router
            )
        }
    }
}


// MARK: - Dummies

final class RepositorySearchResultsInteractingDummy: RepositorySearchResultsInteracting {
    func loadOrganisationRepositories() {}
    func selectResult(at index: Int) {}
}

final class RepositorySearchResultsRoutingDummy: RepositorySearchResultsRouting {
    func routeToURL(_ url: URL) {}
}

final class RepositorySearchResultsPresentingDummy: RepositorySearchResultsPresenting {
    func presentError(_ error: Error) {}
    func presentRepositories(_ repositories: [Repository]) {}
}

// MARK: - Spies

final class RepositorySearchResultsInteractingSpy: RepositorySearchResultsInteracting {
    private(set) var callCount_loadOrganisationRepositories: Int = 0
    private(set) var parametersFor_selectResults: [Int] = []
    
    func loadOrganisationRepositories() {
        callCount_loadOrganisationRepositories += 1
    }
    
    func selectResult(at index: Int) {
        parametersFor_selectResults.append(index)
    }
}

final class RepositorySearchResultsPresentingSpy: RepositorySearchResultsPresenting {
    private(set) var parametersFor_presentRepositories: [[Repository]] = []
    private(set) var parametersFor_presentError: [Error] = []
    
    func presentRepositories(_ repositories: [Repository]) {
        parametersFor_presentRepositories.append(repositories)
    }
    
    func presentError(_ error: Error) {
        parametersFor_presentError.append(error)
    }
}

final class RepositorySearchResultsRoutingSpy: RepositorySearchResultsRouting {
    private(set) var parametersFor_routetoURL: [URL] = []
    
    func routeToURL(_ url: URL) {
        parametersFor_routetoURL.append(url)
    }
}

final class RepositorySearchResultsDisplaySpy: RepositorySearchResultsDisplay {
    private(set) var parametersFor_displayResults: [[String]] = []
    
    func displayRepositoryNames(_ results: [String]) {
        parametersFor_displayResults.append(results)
    }
}
