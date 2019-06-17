//
//  DefaultWireframeTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class DefaultWireframeTests: XCTestCase {
    
    // MARK: - organisationSearchScene()
    
    /*
     DefaultWireframe.organisationSearchScene() should construct a new instance of the scene from its dependencies
     and any arguments that have been handed in.
     */
    
    func test_constructsOrganisationSearchScene() throws {
        // given
        let gitHubSiteServiceDummy = GitHubSiteServiceDummy()
        let scenePresentingDummy = ScenePresentingDummy()
        let defaultWireframe = DefaultWireframe(gitHubSiteService: gitHubSiteServiceDummy, urlOpener: URLOpeningDummy(), scenePresenter: scenePresentingDummy)
        
        // when
        let scene = defaultWireframe.organisationSearchScene()
        
        // then
        
        let wireframe = try expect(scene.wireframe).as(DefaultWireframe.self)
        expect(wireframe).isSameObject(as: defaultWireframe)
        
        let gitHubSiteService = try expect(scene.gitHubSiteService).as(GitHubSiteServiceDummy.self)
        expect(gitHubSiteService).isSameObject(as: gitHubSiteServiceDummy)
        
        let scenePresenter = try expect(scene.scenePresenter).as(ScenePresentingDummy.self)
        expect(scenePresenter).isSameObject(as: scenePresentingDummy)
        
    }
    
    // MARK: - DefaultWireframe.repositorySearchScene()
    
    /*
     DefaultWireframe.repositorySearchScene() should construct a new instance of the scene from its dependencies
     and any arguments that have been handed in.
     */
    
    func test_constructs_repositorySearchScene() throws {
        // given
        let gitHubSiteServiceDummy = GitHubSiteServiceDummy()
        let urlOpeningDummy = URLOpeningDummy()
        let scenePresentingDummy = ScenePresentingDummy()
        let organisation = Organisation(name: "OrganisationName", repositories: [
            Repository(name: "RepositoryName", htmlURL: URL(staticString: "www.repository.com"))
            ])
        let defaultWireframe = DefaultWireframe(gitHubSiteService: gitHubSiteServiceDummy, urlOpener: urlOpeningDummy, scenePresenter: scenePresentingDummy)
        
        // when
        let scene = defaultWireframe.repositorySearchScene(organisation: organisation)
        
        // then
        
        let wireframe = try expect(scene.wireframe).as(DefaultWireframe.self)
        expect(wireframe).isSameObject(as: defaultWireframe)
        expect(scene.organisation).isSameObject(as: organisation)
        let urlOpener = try expect(scene.urlOpener).as(URLOpeningDummy.self)
        expect(urlOpener).isSameObject(as: urlOpeningDummy)
        let gitHubSiteService = try expect(scene.gitHubSiteService).as(GitHubSiteServiceDummy.self)
        expect(gitHubSiteService).isSameObject(as: gitHubSiteService)
        
        expect(scene.gitHubSiteService as! GitHubSiteServiceDummy).isSameObject(as: gitHubSiteServiceDummy)
    }
}


