//
//  FetchStateTests.swift
//  GitHub Repository Search
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest
@testable import GitHub_Repository_Search

final class FetchStateTests: XCTestCase {
    
    // Equal
    
    func test_equal_whenBothAreFetching() {
        let rhs: FetchState<Int, Error> = .fetching
        let lhs: FetchState<Int, Error> = .fetching
        expect(rhs == lhs).is(true)
        expect(lhs == rhs).is(true)
    }
    
    func test_equal_whenBothAreFailureWithEqualErrors() {
        let rhs: FetchState<Int, Error> = .failure(DummyError.error1)
        let lhs: FetchState<Int, Error> = .failure(DummyError.error1)
        expect(rhs == lhs).is(true)
        expect(lhs == rhs).is(true)
    }
    
    func test_equal_whenBothAreSuccessWithEqualValues() {
        let rhs: FetchState<Int, Error> = .success(5)
        let lhs: FetchState<Int, Error> = .success(5)
        expect(rhs == lhs).is(true)
        expect(lhs == rhs).is(true)
    }
    
    // Inequal
    
    func test_inequal_whenFetchingAndFailure() {
        let rhs: FetchState<Int, Error> = .fetching
        let lhs: FetchState<Int, Error> = .failure(DummyError.error1)
        expect(rhs != lhs).is(true)
        expect(lhs != rhs).is(true)
    }
    
    func test_inequal_whenSuccessAndFailure() {
        let rhs: FetchState<Int, Error> = .success(5)
        let lhs: FetchState<Int, Error> = .failure(DummyError.error1)
        expect(rhs != lhs).is(true)
        expect(lhs != rhs).is(true)
    }
    
    func test_inequal_whenBothAreFailureWithInequalErrors() {
        let rhs: FetchState<Int, Error> = .failure(DummyError.error1)
        let lhs: FetchState<Int, Error> = .failure(DummyError.error2)
        expect(rhs != lhs).is(true)
        expect(lhs != rhs).is(true)
    }
    
    func test_equal_whenBothAreSuccessWithInequalValues() {
        let rhs: FetchState<Int, Error> = .success(0)
        let lhs: FetchState<Int, Error> = .success(5)
        expect(rhs != lhs).is(true)
        expect(lhs != rhs).is(true)
    }
}
