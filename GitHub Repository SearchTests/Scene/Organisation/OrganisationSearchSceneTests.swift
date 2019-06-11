//
//  OrganisationSearchSceneTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class OrganisationSearchSceneTests: XCTestCase {
    func test_itWillConstructTheScene() throws {
        
        // given
        
        let gitHubSiteServiceDummy = GitHubSiteServiceDummy()
        let wireframe = Wireframe(gitHubSiteService: gitHubSiteServiceDummy)
        let scene = OrganisationSearchScene(gitHubSiteService: gitHubSiteServiceDummy, wireframe: wireframe)
        
        // when
        
        let viewController = scene.build()
        
        // then
        
        let organisationsSearchViewController = try expect(viewController).as(OrganisationSearchViewController.self)
        let interactor = try expect(organisationsSearchViewController.interactor).as(OrganisationSearchInteractor.self)
        let gitHubSiteService = try expect(interactor.gitHubSiteService).as(GitHubSiteServiceDummy.self)
        expect(gitHubSiteService).isSameObject(as: gitHubSiteServiceDummy)
        
        
        let presenter = try expect(interactor.presenter).as(OrganisationSearchPresenter.self)
        let display = try expect(presenter.display).as(OrganisationSearchViewController.self)
        expect(organisationsSearchViewController).isSameObject(as: display)
        
        let router = try expect(interactor.router).as(OrganisationSearchRouter.self)
        expect(router.sourceViewController).is(organisationsSearchViewController)
        expect(router.wireframe).isSameObject(as: wireframe)
    }
}
