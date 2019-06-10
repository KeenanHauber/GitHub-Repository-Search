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
    /// Returns a list of public repositories for the given organisation, in order of creation. If a list of repositories
    /// have already been fetched, the completion handler will be called synchronously and immediately. This may be overriden
    /// by setting `refresh` to true, in which case the service will fetch new data anyway.
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool, completionHandler: @escaping  (Result<[Repository], Error>) -> Void)
    
    /// Returns a list of organisations containing the given search term in their name.
    ///
    /// - parameter searchTerm: the text to 
    func fetchOrganisations(searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void)
}

// Default implementation
extension GitHubSiteServing {
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionHandler: @escaping  (Result<[Repository], Error>) -> Void) {
        fetchRepositories(forOrganisationNamed: organisationName, refresh: refresh, completionHandler: completionHandler)
    }
}

/// The default implementation of the `GitHubSiteServing` protocol
final class GitHubSiteService: GitHubSiteServing {
    
    // MARK: - Constants
    
    /// Returns the base URL for retrieving a specific organisation's data. This URL is invalid on its own.
    private static let organisationsURL = URL(staticString: "https://api.github.com/orgs/")
    
    /// Attempts to construct a URL which will fetch all repositories for the given organisation
    private static func organisationRepositoriesURL(for organisation: Organisation) -> URL? {
        return URL(string: organisation.name + "/repos", relativeTo: organisationsURL)
    }
    
    /// Returns the base URL for searching user accounts. This URL is invalid on its own.
    private static let userSearchURL = URL(staticString: "https://api.github.com/search/users/")
    
    /// Attempts to construct a URL to search for organisations containing the given search term in their name
    private static func organisationSearchURL(for searchTerm: String) -> URL? {
        return URL(string: "https://api.github.com/search/users?q=\(searchTerm)+in:login+type:org")
    }
    
    // MARK: - Properties
    
    /// The last search term.
    ///
    /// The last search term will not necessarily correlate to the cached organisations, as it may relate to an unsuccessful search,
    /// which will not empty the cache
    private var lastOrganisationSearchTerm: String?
    /// Organisations retrieved from the server in the last successful search
    private var organisations: [Organisation] = []
    
    // MARK: - GitHubSiteServing
    
    func fetchOrganisations(searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {
        guard let organisationSearchURL = GitHubSiteService.organisationSearchURL(for: searchTerm) else {
            return
        }
        
        if refresh == false && lastOrganisationSearchTerm == searchTerm {
            completionHandler(.success(organisations))
            return
        } else {
            fetchData(from: organisationSearchURL) { result in
                switch result {
                case let .success(data):
                    do {
                        let organisations = try JSONDecoder().decode(SearchResults<Organisation>.self, from: data).items
                        self.organisations = organisations
                        completionHandler(.success(organisations))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
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
    
    /// Possible errors thrown by the
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
    
    /// Fetches data from the given URL, returning an error instead if one is thrown
    private func fetchData(from url: URL, completionHandler: @escaping (Result<Data, DataFetchError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                // data & response will be are invalid, so they don't have to be checked
                completionHandler(.failure(.urlSessionError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else  {
                // this should never happen; `URLSession.shared.dataTask(with:)` always returns an instance `HTTPURLResponse` for the value of `response`
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
                print("Unknown response code: \(response.statusCode)")
            }
        }
        
        // Triggers the fetch
        task.resume()
    }
}
