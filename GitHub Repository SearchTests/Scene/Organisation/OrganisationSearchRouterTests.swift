//
//  OrganisationSearchRouterTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class OrganisationSearchRouterTests: XCTestCase {
    
    // MARK: - routeToRepositorySearchResults(for:)
    
    // Expected behaviour: If the Organisation Search scene is wrapped in a navigation controller, routes to Repository Search Results scene.
    
    func test_routesToRepositorySearchResults_pushesViewControllerToNavigationController() throws {
        
        // given
        
        let sourceViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: sourceViewController)
        let organisation = Organisation(name: "", repositories: nil)
        let repositorySearchResultsScene = RepositorySearchResultsScene(
            organisation: organisation,
            gitHubSiteService: GitHubSiteServiceDummy(),
            wireframe: WireframeDummy(),
            urlOpener: URLOpeningDummy()
        )
        
        let wireframeSpy = WireframeSpy(repositorySearchResultsScene: repositorySearchResultsScene)
        let scenePresentingSpy = ScenePresentingSpy()
        let router = OrganisationSearchRouter(sourceViewController: sourceViewController, scenePresenter: scenePresentingSpy, wireframe: wireframeSpy)
        
        // when
        
        router.routeToRepositorySearchResults(for: organisation)
        
        // then
        
        expect(scenePresentingSpy.parametersFor_pushViewController.count).is(1)
        let parameters = scenePresentingSpy.parametersFor_pushViewController.last!
        let passedInNavigationController = try expect(parameters.navigationController).as(UINavigationController.self)
        expect(passedInNavigationController).isSameObject(as: navigationController)
        expect(wireframeSpy.parametersFor_repositorySearchScene.count).is(1)
        expect(wireframeSpy.parametersFor_repositorySearchScene.last).is(organisation)
        let parametersScene = try expect(parameters.scene).as(RepositorySearchResultsScene.self)
        expect(parametersScene).isSameObject(as: repositorySearchResultsScene)
    }
    
    func test_routesToRepositorySearchResults_willNotRoute_whenNoNavigationController() {
        
        // given
        
        let sourceViewController = UIViewController()
        let wireframe = WireframeDummy()
        let scenePresentingSpy = ScenePresentingSpy()
        let router = OrganisationSearchRouter(sourceViewController: sourceViewController, scenePresenter: scenePresentingSpy, wireframe: wireframe)
        let organisation = Organisation(name: "", repositories: nil)
        
        // when
        
        router.routeToRepositorySearchResults(for: organisation)
        
        // then
        
        expect(scenePresentingSpy.parametersFor_pushViewController.isEmpty).is(true)
    }
    
    func test_routesToRepositorySearchResults_willNotRoute_whenNoSourceViewController() {
        
        // given
        
        let scenePresentingSpy = ScenePresentingSpy()
        
        // since the router maintains only a weak reference to the view controller, the view controller will
        // cease to exist after this function is called.
        // no navigation controller is set as it would be deallocated too
        func makeRouter() -> OrganisationSearchRouter {
            let sourceViewController = UIViewController()
            let wireframe = WireframeDummy()
            let router = OrganisationSearchRouter(sourceViewController: sourceViewController, scenePresenter: scenePresentingSpy, wireframe: wireframe)
            
            return router
        }
        
        let router = makeRouter()
        let organisation = Organisation(name: "", repositories: nil)
        
        
        // when
        
        router.routeToRepositorySearchResults(for: organisation)
        
        // then
        
        expect(scenePresentingSpy.parametersFor_pushViewController.isEmpty).is(true)
    }
}
