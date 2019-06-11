//
//  Domain+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

final class GitHubSiteServiceDummy: GitHubSiteServing {
    func fetchOrganisations(searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {}
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionHandler: @escaping (Result<[Repository], Error>) -> Void) {}
}

final class TestGitHubSiteService: GitHubSiteServing {
    
    let fetchRepositoriesResult: Result<[Repository], Error>?
    let fetchOrganisationsResult: Result<[Organisation], Error>?
    
    init(fetchRepositoriesResult: Result<[Repository], Error>? = nil, fetchOrganisationsResult: Result<[Organisation], Error>? = nil) {
        self.fetchRepositoriesResult = fetchRepositoriesResult
        self.fetchOrganisationsResult = fetchOrganisationsResult
    }
    
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionHandler: @escaping (Result<[Repository], Error>) -> Void) {
        if let fetchRepositoriesResult = fetchRepositoriesResult {
            completionHandler(fetchRepositoriesResult)
        }
    }
    
    func fetchOrganisations(searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {
        if let fetchOrganisationsResult = fetchOrganisationsResult {
            completionHandler(fetchOrganisationsResult)
        }
    }
}
