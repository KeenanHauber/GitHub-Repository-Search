//
//  String+StaticStringTests.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class String_StaticStringTests: XCTestCase {
    func test_init_staticString_willPreserveData() {
        
        // given
        let staticStrings: [StaticString] = [
            "",
            "StaticString",
            "Really long string with 1284932 and $%^& and other characters like "
        ]
        
        // when
        let strings = staticStrings.map { String($0) }
        
        // then
        XCTAssertEqual(strings, [
            "",
            "StaticString",
            "Really long string with 1284932 and $%^& and other characters like "
            ])
    }
}
