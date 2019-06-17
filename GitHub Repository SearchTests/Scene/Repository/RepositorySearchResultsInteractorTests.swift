//
//  RepositorySearchResultsInteractorTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 14/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class RepositorySearchResultsInteractorTests: XCTestCase {
    
    // MARK: - selectResult(at:)
    
    /*
     Testing RepositorySearchResultsInteractor.selectResult(at:)
     
     Expected behaviour: the interactor should call to the router to route to the
     HTML URL of the repository at that index so the user may seek view the
     repository on GitHub
    */
    func test_selectResult_routesToURLForRepositoryAtIndex() {
        
        // given
        
        let repositories: [Repository] = [
                Repository(name: "Repository 1", htmlURL: URL(staticString: "www.repository1.com")),
                Repository(name: "Repository 2", htmlURL: URL(staticString: "www.repository2.com"))
        ]
        
        let routerSpy = RepositorySearchResultsRoutingSpy()
        let interactor = RepositorySearchResultsInteractor.build {
            $0.organisation = Organisation(
                name: "",
                repositories: repositories
            )
            $0.router = routerSpy
        }
        
        // when
        
        interactor.selectResult(at: 0)
        interactor.selectResult(at: 1)
        
        // then
        
        expect(routerSpy.parametersFor_routetoURL.count).is(2)
        expect(routerSpy.parametersFor_routetoURL[0]).is(URL(staticString: "www.repository1.com"))
        expect(routerSpy.parametersFor_routetoURL[1]).is(URL(staticString: "www.repository2.com"))
    }
    
    // MARK: - loadOrganisationRepositories()
    
    /*
     Testing RepositorySearchResultsInteractor.loadOrganisationRepositories()
     
     Expected behaviour: the interactor should request a list of repositories
     corellating to the given organisation and present them.
     
     Possible outcomes
     - success: the interactor will present the retrieved repositories
     - failure: the interactor will present the error describing the failure
     
     Since we are dealing with an async call, we should also ensure that if the interactor goes out of scope the application will not crash
    */
    
    func test_loadOrganisationRepositories_willPresentRepositories_whenResultIsSuccess() {
        
        // given
        
        let repositories = [
            Repository(name: "Repository 1", htmlURL: URL(staticString: "www.repository1.com")),
            Repository(name: "Repository 2", htmlURL: URL(staticString: "www.repository2.com"))
        ]
        let testGitHubSiteService = TestGitHubSiteService(fetchRepositoriesResult: .success(repositories))
        let presenterSpy = RepositorySearchResultsPresentingSpy()
        let interactor = RepositorySearchResultsInteractor.build {
            $0.service = testGitHubSiteService
            $0.presenter = presenterSpy
        }
        
        // when
        
        interactor.loadOrganisationRepositories()
        
        // then
        
        expect(presenterSpy.parametersFor_presentRepositories.last).is(repositories)
        expect(presenterSpy.parametersFor_presentError.isEmpty).is(true)
    }
    
    func test_loadOrganisationRepositories_willPresentError_whenResultIsFailure() {
        
        // given
        
        let error = DummyError.error1
        let testGitHubSiteService = TestGitHubSiteService(fetchRepositoriesResult: .failure(error))
        let presenterSpy = RepositorySearchResultsPresentingSpy()
        let interactor = RepositorySearchResultsInteractor.build {
            $0.service = testGitHubSiteService
            $0.presenter = presenterSpy
        }
        
        // when
        
        interactor.loadOrganisationRepositories()
        
        // then
        
        expect(presenterSpy.parametersFor_presentError.last as? DummyError).is(error)
        expect(presenterSpy.parametersFor_presentRepositories.isEmpty).is(true)
    }
    
    func test_theApplication_willNotCrash_whenCompletionHandlerIsCalledAndInteractorIsNil() {
        
        // given
        
        let gitHubSiteServiceSpy = GitHubSiteServiceSpy()
        
        func x(githHubSiteServiceSpy: GitHubSiteServiceSpy) {
            let interactor = RepositorySearchResultsInteractor.build {
                $0.service = gitHubSiteServiceSpy
            }
            
            interactor.loadOrganisationRepositories()
        }
        
        // when
        
        x(githHubSiteServiceSpy: gitHubSiteServiceSpy)
        
        // then; if tests crash, the test has failed. If no crash, this test has passed
        
        expect(gitHubSiteServiceSpy.parametersFor_fetchRepositories.last?.completionHandler).isNotNil()
        gitHubSiteServiceSpy.parametersFor_fetchRepositories.last?.completionHandler(.failure(DummyError.error1))
    }
}
