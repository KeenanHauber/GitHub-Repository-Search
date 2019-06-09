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
    /// Returns a list of repositories for the given organisation. If a list of repositories have already been fetched,
    /// the completion block will be called synchronously.
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool, completionBlock: @escaping  ([Repository]?) -> Void)
}

// Default implementation
extension GitHubSiteServing {
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionBlock: @escaping  ([Repository]?) -> Void) {
        fetchRepositories(forOrganisationNamed: organisationName, refresh: refresh, completionBlock: completionBlock)
    }
}

final class GitHubSiteService: GitHubSiteServing {
    
    // MARK: - Properties
    
    private var search: String?
    // TODO: Remove dummy data
    private var organisations: [Organisation] = [Organisation(name: "", repositories: nil)]
    
    // MARK: - GitHubSiteServing
    
    func fetchRepositories(forOrganisationNamed organisationName: String, refresh: Bool = false, completionBlock: @escaping  (Result<[Repository], Error>) -> Void) {
        guard let organisation = organisations.filter({ $0.name == organisationName }).first else {
            return
        }
        
        if refresh == false, let repositories = organisation.repositories {
            completionBlock(.success(repositories))
        } else {
            fetchData(forResource: GitHubApi(), completionBlock: { result in
                switch result {
                case let .success(data):
                    #warning("Forcibly unwrapping optional string")
                    print(String(data: data, encoding: .utf8)!)
                case .failure(_):
                    #warning("Failure not handled")
                    break
                }
            })
        }
    }
    
    struct GitHubApi: GitHubResource {
        let url = URL(staticString: "https://api.github.com/")
    }
    
    // MARK: - Private Helpers
    
    private func fetchData(forResource gitHubResource: GitHubResource, completionBlock: @escaping (Result<Data, DataFetchError>) -> Void) {
        let task = URLSession.shared.dataTask(with: gitHubResource.url) {(data, response, error) in
            if let error = error {
                // data & response are invalid, so they don't have to be checked
                completionBlock(.failure(.urlSessionError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else  {
                // this should never happen
                return
            }
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    completionBlock(.failure(.noData))
                    return
                }
                completionBlock(.success(data))
            default:
                break
            }
        }
        
        task.resume()
    }
}

#warning("DataFetchError declared in wrong file")
enum DataFetchError: Error {
    case urlSessionError(Error)
    case noData
}
