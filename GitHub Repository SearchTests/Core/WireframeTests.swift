//
//  WireframeTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class WireframeTests: XCTestCase {
    func test_constructsOrganisationSearchScene() {
        // given
        let gitHubSiteService = GitHubSiteServiceDummy()
        let wireframe = Wireframe(gitHubSiteService: gitHubSiteService)
        
        // when
        let scene = wireframe.organisationSearchScene()
        
        XCTAssert(wireframe === scene.wireframe)
        XCTAssert(scene.gitHubSiteService is GitHubSiteServiceDummy)
    }
    
    func test_constructs_repositorySearchScene() {
        // given
        let gitHubSiteService = GitHubSiteServiceDummy()
        let organisation = Organisation(name: "OrganisationName", repositories: [
            Repository(name: "RepositoryName", url: URL(staticString: "www.google.com"), htmlURL: URL(staticString: "www.otherwebsite.com"))
            ])
        let wireframe = Wireframe(gitHubSiteService: gitHubSiteService)
        
        // when
        let scene = wireframe.repositorySearchScene(organisation: organisation)
        
        XCTAssert(scene.wireframe === wireframe)
        XCTAssert(scene.organisation == organisation)
        XCTAssert(scene.gitHubSiteService is GitHubSiteServiceDummy)
    }
}


