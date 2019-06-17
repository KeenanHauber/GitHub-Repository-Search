//
//  RepositorySeachResultsPresenter.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 9/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation

protocol RepositorySearchResultsPresenting {
    ///
    func presentRepositories(_ repositories: [Repository])
    /// Displays the given error to the user
    func presentError(_ error: Error)
}

final class RepositorySearchResultsPresenter: RepositorySearchResultsPresenting {
  
    // MARK: - Dependencies
    
    weak var display: RepositorySearchResultsDisplay?
    
    // MARK: Lifecycle
    
    init(display: RepositorySearchResultsDisplay) {
        self.display = display
    }
    
    // MARK: - RepositorySearchResultsPresenting
    
    func presentRepositories(_ repositories: [Repository]) {
        if repositories.count > 0 {
            display?.displayRepositoryNames(repositories.map { $0.name })
        } else {
            #warning("May allow invalid selection: Display assumes it is receiving a valid list of rows; the interactor will have no cached repositories, creating an invalid index and therefore a crash.")
            #warning("String is not wrapped by a StringKey, preventing localisation and re-use.")
            display?.displayRepositoryNames(["No repositories found"])
        }
    }
    
    func presentError(_ error: Error) {
        #warning("May allow invalid selection: Display assumes it is receiving a valid list of rows; the interactor will have no cached repositories, creating an invalid index and therefore a crash.")
        display?.displayRepositoryNames([error.localizedDescription])
    }
}
