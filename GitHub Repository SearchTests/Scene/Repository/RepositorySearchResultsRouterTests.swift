//
//  RepositorySearchResultsRouterTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 17/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class RepositorySearchResultsRouterTests: XCTestCase {
    
    // MARK: - routeToURL(_:)
    
    // Expected behaviour: Opens the URL with no options and no completion handler
    
    func test_routeToURL_opensURL() {
        
        // given
        
        let urlOpeningSpy = URLOpeningSpy()
        let router = RepositorySearchResultsRouter(urlOpener: urlOpeningSpy)
        let url = URL(staticString: "www.some.website.com")
        
        // when
        
        router.routeToURL(url)
        
        // then
        
        expect(urlOpeningSpy.parametersFor_openURLOptionsCompletionHandler.count).is(1)
        let parameters = urlOpeningSpy.parametersFor_openURLOptionsCompletionHandler.last
        expect(parameters?.url).is(url)
        expect(parameters?.completionHandler).isNil()
        expect(parameters?.options.isEmpty).is(true)
    }
}
