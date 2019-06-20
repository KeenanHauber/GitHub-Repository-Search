//
//  GitHubSiteServiceTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 20/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class GitHubSiteServiceTests: XCTestCase {
    /*
     Testing GitHubSiteService.fetchOrganisations(withNamesContaining:refresh:completionHandler:)
     
     # Expected behaviour
     
     When a search for organisations is made, the correct URL will be constructed and data will be fetched through the HTTPClient
     
     If a search for organisations using the same search term has already been made, and `refresh` is `false`:
     - a second fetch will not be triggered, and the completion block will be passed the same arguments as resulting from the first fetch
     
     If a search for organisations using the same search term has already been made, and `refresh` is `true`:
     - a second fetch will be triggered, and the completion block will be passed the result of the new fetch
     
     A search for organisations using a different search term will fetch data from the server even if refresh is false
     */
    func test_fetchOrganisations_willCallCompletionHandlerWithFetchedOrganisations() throws {
        
        // given
        
        let organisations: [Organisation] = [
            Organisation(name: "Name", repositories: nil)
        ]
        let searchResults = SearchResults(totalCount: 1, incompleteResults: false, items: organisations)
        let data = try JSONEncoder().encode(searchResults)
        
        let httpClientSpy = HTTPClientSpy(result: .success(data))
        let gitHubSiteService = GitHubSiteService(httpClient: httpClientSpy)
        
        var completionBlockCalled = false
        
        // when
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: "Name", refresh: false, completionHandler: { result in
            completionBlockCalled = true
            switch result {
            case let .failure(error):
                XCTFail("Expected success but got an error: \(error)")
            case let .success(success):
                self.expect(success).is(organisations)
            }
        })
        
        expect(httpClientSpy.parametersFor_fetchData.count).is(1)
        expect(httpClientSpy.parametersFor_fetchData.last?.url).is(URL(staticString: "https://api.github.com/search/users?q=Name+in:login+type:org"))
        
        expect(completionBlockCalled).is(true)
    }
    
    func test_fetchOrganisations_usesCachedSearchResultsForSameSearchTerm_whenRefreshIsFalse() throws {
        
        // given
        
        let searchTerm = "Name"
        
        let organisations: [Organisation] = [
            Organisation(name: "Name", repositories: nil)
        ]
        let searchResults = SearchResults(totalCount: 1, incompleteResults: false, items: organisations)
        let data = try JSONEncoder().encode(searchResults)
        
        let httpClientSpy = HTTPClientSpy(result: .success(data))
        let gitHubSiteService = GitHubSiteService(httpClient: httpClientSpy)
        
        var completionBlockCalled = false
        
        // when
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: searchTerm, refresh: false, completionHandler: { _ in })
        
        // Change the result so we know that if a valid result is returned for the second fetch, it's coming from the first fetch
        httpClientSpy.result = .failure(HTTPRequestError.noData)
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: searchTerm, refresh: false, completionHandler: { result in
            completionBlockCalled = true
            switch result {
            case let .failure(error):
                XCTFail("Expected success but got an error: \(error)")
            case let .success(success):
                self.expect(success).is(organisations)
            }
        })
        
        expect(httpClientSpy.parametersFor_fetchData.count).is(1)
        expect(httpClientSpy.parametersFor_fetchData.last?.url).is(URL(staticString: "https://api.github.com/search/users?q=Name+in:login+type:org"))
        
        expect(completionBlockCalled).is(true)
    }
    
    func test_fetchOrganisations_willNotUseCachedSearchResultsForSameSearchTerm_whenRefreshIsTrue() throws {
        
        // given
        
        let searchTerm = "Name"
        
        let organisations: [Organisation] = [
            Organisation(name: "Name", repositories: nil)
        ]
        let searchResults = SearchResults(totalCount: 1, incompleteResults: false, items: organisations)
        let data = try JSONEncoder().encode(searchResults)
        
        let httpClientSpy = HTTPClientSpy(result: .success(data))
        let gitHubSiteService = GitHubSiteService(httpClient: httpClientSpy)
        
        var completionBlockCalled = false
        
        // when
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: searchTerm, refresh: false, completionHandler: { _ in })
        
        // Change the result so we know that if a valid result is returned for the second fetch, it's coming from the first fetch
        httpClientSpy.result = .failure(HTTPRequestError.noData)
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: searchTerm, refresh: true, completionHandler: { result in
            completionBlockCalled = true
            switch result {
            case let .failure(error):
                self.expect(error.localizedDescription).is(HTTPRequestError.noData.localizedDescription)
            case let .success(success):
                XCTFail("Expected error but got success: \(success)")
            }
        })
        
        expect(httpClientSpy.parametersFor_fetchData.count).is(2)
        expect(httpClientSpy.parametersFor_fetchData.last?.url).is(URL(staticString: "https://api.github.com/search/users?q=Name+in:login+type:org"))
        
        expect(completionBlockCalled).is(true)
    }
    
    func test_fetchOrganisations_willNotUseCachedSearchResults_whenSearchTermChanges() throws {
        
        // given
        
        let organisations: [Organisation] = [
            Organisation(name: "Name", repositories: nil)
        ]
        let searchResults = SearchResults(totalCount: 1, incompleteResults: false, items: organisations)
        let data = try JSONEncoder().encode(searchResults)
        
        let httpClientSpy = HTTPClientSpy(result: .success(data))
        let gitHubSiteService = GitHubSiteService(httpClient: httpClientSpy)
        
        var completionBlockCalled = false
        
        // when
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: "SearchTerm", refresh: false, completionHandler: { _ in })
        
        // Change the result so we know that if a valid result is returned for the second fetch, it's coming from the first fetch
        httpClientSpy.result = .failure(HTTPRequestError.noData)
        
        gitHubSiteService.fetchOrganisations(withNamesContaining: "Different", refresh: false, completionHandler: { result in
            completionBlockCalled = true
            switch result {
            case let .failure(error):
                self.expect(error.localizedDescription).is(HTTPRequestError.noData.localizedDescription)
            case let .success(success):
                XCTFail("Expected error but got success: \(success)")
            }
        })
        
        expect(httpClientSpy.parametersFor_fetchData.count).is(2)
        expect(httpClientSpy.parametersFor_fetchData.last?.url).is(URL(staticString: "https://api.github.com/search/users?q=Different+in:login+type:org"))
        
        expect(completionBlockCalled).is(true)
    }
}
