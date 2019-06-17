//
//  RepositorySearchResultsViewControllerTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 12/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class RepositorySearchResultsViewControllerTests: XCTestCase {
    func test_viewDidLoad_loadsOrganisationRepositories() {
        
        // given
        
        let viewController = RepositorySearchResultsViewController()
        let interactingSpy = RepositorySearchResultsInteractingSpy()
        viewController.interactor = interactingSpy
        
        // when
        
        _ = viewController.view
        
        // then
        
        expect(interactingSpy.callCount_loadOrganisationRepositories).is(1)
    }
    
    func test_displayResults_displaysResults() {
        
        // given
        
        let viewController = RepositorySearchResultsViewController()
        let interactingDummy = RepositorySearchResultsInteractingDummy()
        viewController.interactor = interactingDummy
        let tableView = viewController.tableView!
        
        let repositoryTitles: [String] = [
            "Result 1",
            "Another Result",
            "This is the name of a repository",
            "Title #4"
        ]
        
        // when
        
        viewController.displayRepositoryNames(repositoryTitles)
        
        // then
        
        #warning("this doesn't actually test whether reloadData() has been called, or what the table is actually displaying")
        expect(viewController.tableView(tableView, numberOfRowsInSection: 0)).is(4)
        expect(viewController.tableView.dataSource === viewController).is(true)
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)).textLabel?.text).is(repositoryTitles[0])
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)).textLabel?.text).is(repositoryTitles[1])
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 0)).textLabel?.text).is(repositoryTitles[2])
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 3, section: 0)).textLabel?.text).is(repositoryTitles[3])
    }
    
    func test_numberOfSections_isOne() {
        expect(RepositorySearchResultsViewController().numberOfSections(in: UITableView())).is(1)
    }
    
    func test_didSelectRowAt_notifiesInteractor() {
        
        // given
        
        let viewController = RepositorySearchResultsViewController()
        let interactingSpy = RepositorySearchResultsInteractingSpy()
        viewController.interactor = interactingSpy
        
        // when
        
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 5, section: 0))
        
        // then
        
        expect(interactingSpy.parametersFor_selectResults.count).is(1)
        expect(interactingSpy.parametersFor_selectResults.last).is(5)
    }
}
