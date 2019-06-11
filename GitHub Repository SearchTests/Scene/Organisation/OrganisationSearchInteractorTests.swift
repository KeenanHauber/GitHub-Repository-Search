//
//  OrganisationSearchInteractorTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class OrganisationSearchInteractorTests: XCTestCase {
    func test_searchForOrganisations_presentsFetching() {
        
        // given
        
        // when nil, will not call completion, so can track whether the interactor sets state to fetching before the fetch succeeds
        let gitHubSiteServiceDummy = TestGitHubSiteService(fetchOrganisationsResult: nil)
        let presenterSpy = OrganisationPresenterSpy()
        
        let interactor = OrganisationSearchInteractor(
            presenter: presenterSpy,
            router: OrganisationSearchRoutingDummy(),
            gitHubSiteService: gitHubSiteServiceDummy
        )
        
        // when
        
        interactor.searchForOrganisations(named: "")
        
        // then
        
        // First fetching, then failure
        XCTAssert(presenterSpy.parametersFor_presentFetchState.count == 1)
        XCTAssert(presenterSpy.mostRecentParameterFor_presentFetchState == .fetching)
    }
    
    func test_searchForOrganisations_presentsFailureForFailedFetch() {
        
        // given
        let fetchResult = DummyError.error1
        
        let gitHubSiteServiceDummy = TestGitHubSiteService(fetchOrganisationsResult: .failure(fetchResult))
        let presenterSpy = OrganisationPresenterSpy()
        
        let interactor = OrganisationSearchInteractor(
            presenter: presenterSpy,
            router: OrganisationSearchRoutingDummy(),
            gitHubSiteService: gitHubSiteServiceDummy
        )
        
        // when
        
        interactor.searchForOrganisations(named: "")
        
        // then
        
        // First fetching, then failure
        XCTAssert(presenterSpy.parametersFor_presentFetchState.count == 2)
        XCTAssert(presenterSpy.mostRecentParameterFor_presentFetchState == .failure(fetchResult))
    }
    
    func test_searchForOrganisations_presentsSuccessForSuccessfulFetch() {
        
        // given
        
        let fetchResult = [Organisation(name: "", repositories: [])]
        
        let gitHubSiteServiceDummy = TestGitHubSiteService(fetchOrganisationsResult: .success(fetchResult))
        let presenterSpy = OrganisationPresenterSpy()
        
        let interactor = OrganisationSearchInteractor(
            presenter: presenterSpy,
            router: OrganisationSearchRoutingDummy(),
            gitHubSiteService: gitHubSiteServiceDummy
        )
        
        // when
        
        interactor.searchForOrganisations(named: "")
        
        // then
        
        // First fetching, then failure
        XCTAssert(presenterSpy.parametersFor_presentFetchState.count == 2)
        XCTAssert(presenterSpy.mostRecentParameterFor_presentFetchState == .success(fetchResult))
    }
    
    func test_userSelectedORganisationAtRow_routesToRepositorySearchResultsForOrganisation() {
        // given
        
        let fetchResult = [
            Organisation(name: "Organisation One", repositories: []),
            Organisation(name: "TOAHASN", repositories: []),
            Organisation(name: "The Third", repositories: [])
        ]
        
        let gitHubSiteServiceDummy = TestGitHubSiteService(fetchOrganisationsResult: .success(fetchResult))
        let routerSpy = OrganisationSearchRouterSpy()
        
        let interactor = OrganisationSearchInteractor(
            presenter: OrganisationSearchPresentingDummy(),
            router: routerSpy,
            gitHubSiteService: gitHubSiteServiceDummy
        )
        
        // when
        
        // First trigger a fetch to cache the orgaisations
        interactor.searchForOrganisations(named: "")
        
        interactor.userSelectedOrganisationAt(row: 1)
        
        // then
        
        expect(routerSpy.parametersFor_routeToRepositorySearchResults.count).is(1)
        expect(routerSpy.parametersFor_routeToRepositorySearchResults.last).is(fetchResult[1])
    }
}
