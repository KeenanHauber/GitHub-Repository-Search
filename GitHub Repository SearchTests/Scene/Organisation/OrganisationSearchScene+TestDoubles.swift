//
//  OrganisationSearchScene+TestDoubles.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import Foundation
@testable import GitHub_Repository_Search

// MARK: - Dummies

final class OrganisationSearchRoutingDummy: OrganisationSearchRouting {
    func routeToRepositorySearchResults(for organisation: Organisation) {}
}

final class OrganisationSearchPresentingDummy: OrganisationSearchPresenting {
    func presentFetchState(_ fetchState: FetchState<[Organisation], Error>) {}
}

// MARK: - Spies

final class OrganisationSearchRouterSpy: OrganisationSearchRouting {
    private(set) var parametersFor_routeToRepositorySearchResults: [Organisation] = []
    func routeToRepositorySearchResults(for organisation: Organisation) {
        parametersFor_routeToRepositorySearchResults.append(organisation)
    }
}

final class OrganisationSearchInteractorSpy: OrganisationSearchInteracting {
    private var parametersFor_searchForOrganisations: [String] = []
    var callCount_searchForOrganisations: Int {
        return parametersFor_searchForOrganisations.count
    }
    var mostRescentParameterFor_searchForOrganisations: String? {
        return parametersFor_searchForOrganisations.last
    }
    func searchForOrganisations(named searchTerm: String) {
        parametersFor_searchForOrganisations.append(searchTerm)
    }
    
    private(set) var parametersFor_selectedOrganisationAt: [Int] = []
    var callCount_selectedOrganisationAt: Int {
        return parametersFor_selectedOrganisationAt.count
    }
    var mostRescentParameterFor_selectedOrganisationAt: Int? {
        return parametersFor_selectedOrganisationAt.last
    }
    func userSelectedOrganisationAt(row: Int) {
        parametersFor_selectedOrganisationAt.append(row)
    }
}

final class OrganisationPresenterSpy: OrganisationSearchPresenting {
    var parametersFor_presentFetchState: [FetchState<[Organisation], Error>] = []
    var mostRecentParameterFor_presentFetchState: FetchState<[Organisation], Error>? {
        return parametersFor_presentFetchState.last
    }
    
    func presentFetchState(_ fetchState: FetchState<[Organisation], Error>) {
        parametersFor_presentFetchState.append(fetchState)
    }
}

final class OrganisationSearchDisplaySpy: OrganisationSearchDisplay {
    private var parametersFor_displayOrganisations: [[String]] = []
    var callCount_displayOrganisations: Int {
        return parametersFor_displayOrganisations.count
    }
    var mostRecentParameterFor_displayOrganisations: [String]? {
        return parametersFor_displayOrganisations.last
    }
    
    func displayOrganisations(_ organisations: [String]) {
        parametersFor_displayOrganisations.append(organisations)
    }
    
    private var parametersFor_displayErrorMessage: [String] = []
    var callCount_displayErrorMessage: Int {
        return parametersFor_displayErrorMessage.count
    }
    var mostRecentParameterFor_displayErrorMessage: String? {
        return parametersFor_displayErrorMessage.last
    }
    func displayErrorMessage(_ message: String) {
        parametersFor_displayErrorMessage.append(message)
    }
    
    var displayBusyStateCallCount = 0
    func displayBusyState() {
        displayBusyStateCallCount += 1
    }
}
