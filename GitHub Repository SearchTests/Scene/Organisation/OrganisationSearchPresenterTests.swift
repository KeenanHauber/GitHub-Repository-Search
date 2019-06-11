//
//  OrganisationSearchPresenterTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class OrganisationSearchPresenterTests: XCTestCase {
    func test_presentFetchState_displaysBusyState_whenFetchStateIsFetching() {
        // given
        let displaySpy = OrganisationSearchDisplaySpy()
        let presenter = OrganisationSearchPresenter(display: displaySpy)
        
        // when
        presenter.presentFetchState(.fetching)
        
        // then
        XCTAssert(displaySpy.displayBusyStateCallCount == 1)
    }
    
    func test_presentFetchState_displaysError_whenFetchStateIsFailure() {
        // given
        let fetchResult = DummyError.error1
        let displaySpy = OrganisationSearchDisplaySpy()
        let presenter = OrganisationSearchPresenter(display: displaySpy)
        
        // when
        presenter.presentFetchState(.failure(fetchResult))
        
        // then
        XCTAssert(displaySpy.callCount_displayErrorMessage == 1)
        expect(displaySpy.mostRecentParameterFor_displayErrorMessage).is(fetchResult.localizedDescription)
    }
    
    func test_presentFetchState_displaysOrganisations_whenFetchStateIsSuccess() {
        // given
        let displaySpy = OrganisationSearchDisplaySpy()
        let presenter = OrganisationSearchPresenter(display: displaySpy)
        let organisations = [
            Organisation(name: "Organisation 1", repositories: nil),
            Organisation(name: "The Yellow Organisation", repositories: nil),
            Organisation(name: "There is no organisation", repositories: nil)
        ]
        
        // when
        presenter.presentFetchState(.success(organisations))
        
        // then
        expect(displaySpy.callCount_displayOrganisations).is(1)
        expect(displaySpy.mostRecentParameterFor_displayOrganisations).is(organisations.map { $0.name })
    }
}
