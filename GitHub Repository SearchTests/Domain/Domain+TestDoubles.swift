//
//  Domain+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

// MARK: - Dummies

final class GitHubSiteServiceDummy: GitHubSiteServing {
    func fetchOrganisations(withNamesContaining searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {}
    func fetchRepositories(for organisation: Organisation, refresh: Bool, completionHandler: @escaping (Result<[Repository], Error>) -> Void) {}
}

// MARK: - Spies

final class GitHubSiteServiceSpy: GitHubSiteServing {
    
    private(set) var parametersFor_fetchRepositories: [(organisation: Organisation, refresh: Bool, completionHandler: (Result<[Repository], Error>) -> Void)] = []
    
    private(set) var parametersFor_fetchOrganisations: [(searchTerm: String, refresh: Bool, completionHandler: (Result<[Organisation], Error>) -> Void)] = []
    
    func fetchRepositories(for organisation: Organisation, refresh: Bool, completionHandler: @escaping (Result<[Repository], Error>) -> Void) {
        parametersFor_fetchRepositories.append((organisation, refresh, completionHandler))
    }
    
    func fetchOrganisations(withNamesContaining searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {
        parametersFor_fetchOrganisations.append((searchTerm, refresh, completionHandler))
    }
}

// MARK: - Mock data

final class TestGitHubSiteService: GitHubSiteServing {
    
    let fetchRepositoriesResult: Result<[Repository], Error>?
    let fetchOrganisationsResult: Result<[Organisation], Error>?
    
    init(fetchRepositoriesResult: Result<[Repository], Error>? = nil, fetchOrganisationsResult: Result<[Organisation], Error>? = nil) {
        self.fetchRepositoriesResult = fetchRepositoriesResult
        self.fetchOrganisationsResult = fetchOrganisationsResult
    }
    
    func fetchRepositories(for organisation: Organisation, refresh: Bool, completionHandler: @escaping (Result<[Repository], Error>) -> Void) {
        if let fetchRepositoriesResult = fetchRepositoriesResult {
            completionHandler(fetchRepositoriesResult)
        }
    }
    
    func fetchOrganisations(withNamesContaining searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {
        if let fetchOrganisationsResult = fetchOrganisationsResult {
            completionHandler(fetchOrganisationsResult)
        }
    }
}
