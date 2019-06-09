//
//  GitHubSiteService.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

/// An abstraction of network communications designed to give access to the GitHub API.
protocol GitHubSiteServing {
    /// Returns a list of public repositories for the given organisation, in order of creation. If a list of repositories have already been fetched,
    /// the completion handler will be called synchronously and immediately. This may be overriden by setting `refresh` to true, in which case
    /// the service will fetch new data anyway.
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool, completionHandler: @escaping  ([Repository]?) -> Void)
}

// Default implementation
extension GitHubSiteServing {
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionHandler: @escaping  ([Repository]?) -> Void) {
        fetchRepositories(forOrganisationNamed: organisationName, refresh: refresh, completionHandler: completionHandler)
    }
}

final class GitHubSiteService: GitHubSiteServing {
    
    // MARK: - Constants
    
    private static let organisationsURL = URL(staticString: "https://api.github.com/orgs/")
    
    private static func organisationRepositoriesURL(for organisation: Organisation) -> URL? {
        return URL(string: organisation.name + "/repos", relativeTo: organisationsURL)
    }
    
    // MARK: - Properties
    
    private var search: String?
    // TODO: Remove dummy data
    private var organisations: [Organisation] = [Organisation(name: "spring", repositories: nil)]
    
    // MARK: - GitHubSiteServing
    
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionHandler: @escaping  (Result<[Repository], Error>) -> Void) {
        guard let organisation = organisations.filter({ $0.name == organisationName }).first,
            let organisationRepositoriesURL = GitHubSiteService.organisationRepositoriesURL(for: organisation) else {
            return
        }
        
        if refresh == false, let repositories = organisation.repositories {
            completionHandler(.success(repositories))
        } else {
            fetchData(from: organisationRepositoriesURL, completionHandler: { result in
                switch result {
                case let .success(data):
                    do {
                        let repositories: [Repository] = try JSONDecoder().decode([Repository].self, from: data)
                        completionHandler(.success(repositories))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
        }
    }
    
    // MARK: - Private Helpers
    
    private enum DataFetchError: Error {
        /// Indicates an error within URLSession.shared.dataTask(with:completionHandler:)
        case urlSessionError(Error)
        /// Indicates a successful request (code 200) with no data returned
        case noData
        /// Indicates a response code 400
        case badRequest
        /// Indicates a 404 error
        case notFound
    }
    
    private func fetchData(from url: URL, completionHandler: @escaping (Result<Data, DataFetchError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                // data & response are invalid, so they don't have to be checked
                completionHandler(.failure(.urlSessionError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else  {
                // this should never happen
                return
            }
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    completionHandler(.failure(.noData))
                    return
                }
                completionHandler(.success(data))
            case 404:
                completionHandler(.failure(.notFound))
            default:
                print(response.statusCode)
            }
        }
        
        // Triggers the fetch
        task.resume()
    }
}
