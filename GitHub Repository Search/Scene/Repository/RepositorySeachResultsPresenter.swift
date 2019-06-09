//
//  RepositorySeachResultsPresenter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol RepositorySearchResultsPresenting {
    func presentRepositories(_ repositories: [Repository])
    func presentError(_ error: Error)
}

final class RepositorySearchResultsPresenter: RepositorySearchResultsPresenting {
  
    // MARK: - Dependencies
    
    private weak var display: RepositorySearchResultsDisplay?
    
    // MARK: Lifecycle
    
    init(display: RepositorySearchResultsDisplay) {
        self.display = display
    }
    
    // MARK: - RepositorySearchResultsPresenting
    
    func presentRepositories(_ repositories: [Repository]) {
        if repositories.count > 0 {
            display?.displayResults(repositories.map { $0.name })
        } else {
            display?.displayResults(["No repositories found"])
        }
    }
    
    func presentError(_ error: Error) {
        display?.displayResults([error.localizedDescription])
    }
}
