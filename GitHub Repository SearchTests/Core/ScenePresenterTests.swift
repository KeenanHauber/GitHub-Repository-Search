//
//  RoutingTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class RoutingTests: XCTestCase {
    
    func test_pushesViewControllerToNavigationController() throws {
        
        // given
        
        let id = 1253
        let router = ScenePresenter()
        let scene = DummyScene(testID: id)
        let navigationController = NavigationControllingSpy()
        
        // when
        
        router.pushViewController(for: scene, to: navigationController)
        
        // then
        
        let dummySceneViewController = try expect(navigationController.parametersFor_pushViewController.last!.viewController).as(DummySceneViewController.self)
        expect(dummySceneViewController.testID).is(id)
        expect(navigationController.parametersFor_pushViewController.last!.animated).is(true)
    }
}
