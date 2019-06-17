//
//  RepositorySearchResultsPresenterTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class RepositorySearchResultsPresenterTests: XCTestCase {
    
    // MARK: - presentRepositories(_:)
    
    /*
     Testing RepositorySearchResultsPresenter.presentRepositories(_:)
     
     Expected behaviour: the presenter should display the repositories' names
     
     Possible outcomes:
     - at least one repository: the presenter will display the repositories' names
     - no repositories: the presenter will display a message as if it were a repository name
     
     */
    
    func test_presentRepositories_willDisplayRepositoryNames_whenThereIsAtLeastOneRepository() {
        
        // given
        
        let displaySpy = RepositorySearchResultsDisplaySpy()
        let presenter = RepositorySearchResultsPresenter(display: displaySpy)
        let repositories = [Repository(name: "Repository Name", htmlURL: URL(staticString: "www.repository.com"))]
        
        // when
        
        presenter.presentRepositories(repositories)
        
        // then
        
        expect(displaySpy.parametersFor_displayResults.count).is(1)
        expect(displaySpy.parametersFor_displayResults.last).is(["Repository Name"])
    }
    
    func test_presentRepositories_willDisplayRepositoryNamesWithNoRepositoriesMessageAsOnlyEntry_whenThereAreNoRepositories() {
        
        // given
        
        let displaySpy = RepositorySearchResultsDisplaySpy()
        let presenter = RepositorySearchResultsPresenter(display: displaySpy)
        
        // when
        
        presenter.presentRepositories([])
        
        // then
        
        expect(displaySpy.parametersFor_displayResults.count).is(1)
        expect(displaySpy.parametersFor_displayResults.last).is(["No repositories found"])
    }
    
    // MARK: - presentError(_:)
    
    /*
     Testing RepositorySearchResultsPresenter.presentError(_:)
 
     Expected behaviour: Display the error as if it were a repository's name
     */
    
    func test_presentError_willDisplayRepositoryNamesWithErrorDescriptionAsOnlyEntry() {
        
        // given
        
        let displaySpy = RepositorySearchResultsDisplaySpy()
        let presenter = RepositorySearchResultsPresenter(display: displaySpy)
        let error = DummyError.error1
        
        // when
        
        presenter.presentError(error)
        
        // then
        
        expect(displaySpy.parametersFor_displayResults.count).is(1)
        expect(displaySpy.parametersFor_displayResults.last).is([error.localizedDescription])
        
    }
}
