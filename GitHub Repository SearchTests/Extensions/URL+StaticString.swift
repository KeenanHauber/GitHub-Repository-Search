//
//  URL+StaticStringTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class URL_StaticStringTests: XCTestCase {
    func test_initStaticString_willConstructURL() {
        _ = URL(staticString: "www.google.com")
    }
}

