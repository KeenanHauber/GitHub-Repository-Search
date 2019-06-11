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
