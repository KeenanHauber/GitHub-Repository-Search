//
//  RepositorySearchResultsSceneTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class RepositorySearchResultsSceneTests: XCTestCase {
    func test_itBuildsTheScene() throws {
        
        // given
        
        let organisation = Organisation(name: "", repositories: nil)
        let gitHubSiteServiceDummy = GitHubSiteServiceDummy()
        let urlOpeningDummy = URLOpeningDummy()
        let wireframe = WireframeDummy()
        
        let scene = RepositorySearchResultsScene(organisation: organisation, gitHubSiteService: gitHubSiteServiceDummy, wireframe: wireframe, urlOpener: urlOpeningDummy)
        
        // when
        
        let viewController = scene.build()
        
        // then
        
        let repositorySearchResultsViewController = try expect(viewController).as(RepositorySearchResultsViewController.self)
        let interactor = try expect(repositorySearchResultsViewController.interactor).as(RepositorySearchResultsInteractor.self)
        expect(interactor.organisation).is(organisation)
        let gitHubSiteService = try expect(interactor.service).as(GitHubSiteServiceDummy.self)
        expect(gitHubSiteServiceDummy).isSameObject(as: gitHubSiteService)
        
        let presenter = try expect(interactor.presenter).as(RepositorySearchResultsPresenter.self)
        let display = try expect(presenter.display).as(RepositorySearchResultsViewController.self)
        expect(repositorySearchResultsViewController).isSameObject(as: display)
        
        _ = try expect(interactor.router).as(RepositorySearchResultsRouter.self)
    }
}
