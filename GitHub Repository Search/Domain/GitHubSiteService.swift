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
    /**
     Asynchrounously fetches a list of public repositories for the given organisation, in order of creation.
     
     - parameter organisation: the organisation for which associated repositories will be fetched
     - parameter refresh: forces data to be fetched from the server, even if there is cached data
     - parameter completionHandler: called when the fetch has completed
     
     Repositories for a fetch are automatically cached in the organisation object. If a list of repositories
     have already been fetched, the completion handler will be called synchronously with no new query being executed.
     This may be overriden by setting `refresh` to true, in which case the service will fetch new data anyway.
     */
    func fetchRepositories(for organisation: Organisation, refresh: Bool, completionHandler: @escaping (Result<[Repository], Error>) -> Void)
 
    
    /**
     Asynchronously a list of organisations matching the search term from GitHub.
     
     - parameter searchTerm: filter text to identify a set of organisations, by matching it against their name
     - parameter refresh: forces data to be fetched from the server, even if there is cached data
     - parameter completionHandler: called when the fetch has completed
     
     Organisations for a search term are automatically cached to save re-fetching data that has already been successfully fetched. If a search is executed twice
     and the first was successful, completion handler will be called synchronously with no new query being executed. A proper fetch may be forced by setting
     `refresh` to `true`.
     */
    func fetchOrganisations(withNamesContaining searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void)
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
        return URL(string: "https://api.github.com/search/users?q=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))+in:login+type:org")
    }
    
    // MARK: - Dependencies
    
    let httpClient: HTTPClient
    
    // MARK: - Lifecycle
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: - Properties
    
    /// The last search term.
    ///
    /// The last search term will not necessarily correlate to the cached organisations, as it may relate to an unsuccessful search,
    /// which will not empty the cache
    private var lastOrganisationSearchTerm: String?
    /// Organisations retrieved from the server in the last successful search
    private var organisationsRetrievedByLastSearch: [Organisation] = []
    
    // MARK: - GitHubSiteServing
    
    func fetchOrganisations(withNamesContaining searchTerm: String, refresh: Bool, completionHandler: @escaping (Result<[Organisation], Error>) -> Void) {
        guard let organisationSearchURL = GitHubSiteService.organisationSearchURL(for: searchTerm) else {
            return
        }
        
        if refresh == false && lastOrganisationSearchTerm == searchTerm {
            completionHandler(.success(organisationsRetrievedByLastSearch))
            return
        } else {
            lastOrganisationSearchTerm = searchTerm
            httpClient.fetchData(from: organisationSearchURL) { result in
                switch result {
                case let .success(data):
                    do {
                        let organisations = try JSONDecoder().decode(SearchResults<Organisation>.self, from: data).items
                        self.organisationsRetrievedByLastSearch = organisations
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
    
    func fetchRepositories(for organisation: Organisation, refresh: Bool = false, completionHandler: @escaping  (Result<[Repository], Error>) -> Void) {
        guard let organisationRepositoriesURL = GitHubSiteService.organisationRepositoriesURL(for: organisation) else {
            return
        }
        
        if refresh == false, let repositories = organisation.repositories {
            completionHandler(.success(repositories))
        } else {
            httpClient.fetchData(from: organisationRepositoriesURL, completionHandler: { result in
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
}
