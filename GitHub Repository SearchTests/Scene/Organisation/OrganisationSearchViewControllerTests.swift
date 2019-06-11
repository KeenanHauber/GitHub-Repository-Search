//
//  OrganisationSearchViewControllerTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class OrganisationSearchViewControllerTests: XCTestCase {
    func test_displayOrganisations_willDisplayOrganisationsInTableView() {
        
        // given
        
        let viewController = OrganisationSearchViewController()
        
        _ = viewController.view
        
        let organisations = ["Organisation 1", "Just another organisation", "The Third One"]
        let tableView = viewController.tableView!
        
        // when
        
        viewController.displayOrganisations(organisations)
        
        // then
        
        expect(viewController.tableView(tableView, numberOfRowsInSection: 0)).is(3)
        expect(viewController.tableView.delegate === viewController).is(true)
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)).textLabel?.text).is(organisations[0])
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)).textLabel?.text).is(organisations[1])
        expect(viewController.tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 0)).textLabel?.text).is(organisations[2])
    }
    
    func test_numberOfSections() {
        expect(OrganisationSearchViewController().numberOfSections(in: UITableView())).is(1)
    }
    
    func test_viewDidLoad_addsSearchBarToNavigationItem() throws {
        
        // given
        
        let viewController = OrganisationSearchViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // when

        _ = viewController.view
        
        // then
        
        let searchBar = try expect(navigationController.navigationBar.topItem?.titleView).as(UISearchBar.self)
        expect(searchBar.delegate === viewController).is(true)
        expect(searchBar.placeholder).is("Search GitHub Organisations")
    }
    
    func test_didSelectRowAt_notifiesInteractor() {
        
        // given
        
        let viewController = OrganisationSearchViewController()
        let interactorSpy = OrganisationSearchInteractorSpy()
        viewController.interactor = interactorSpy
        
        // when
        
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 5, section: 20))
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 100, section: 0))
        
        // then
    
        expect(interactorSpy.callCount_selectedOrganisationAt).is(3)
        expect(interactorSpy.parametersFor_selectedOrganisationAt).is([0, 5, 100])
    }
    
    func test_searchBarSearchButtonClicked_searchesForOrganisations() {
        
        // given
        
        let viewController = OrganisationSearchViewController()
        let interactorSpy = OrganisationSearchInteractorSpy()
        viewController.interactor = interactorSpy
        
        let searchBar = UISearchBar()
        searchBar.text = "Text"
        
        // when
        
        viewController.searchBarSearchButtonClicked(searchBar)
        
        // then
        
        expect(interactorSpy.callCount_searchForOrganisations).is(1)
        expect(interactorSpy.mostRescentParameterFor_searchForOrganisations).is("Text")
    }
}
