//
//  XCTestCase+Expect.swift
//  GitHub Repository SearchTests
//
//  Created by Keenan Hauber on 11/6/19.
//  Copyright © 2019 Keenan Hauber. All rights reserved.
//

import XCTest

extension XCTestCase {
    /// Possible errors describing a failed expectation
    enum ExpectationError: Error {
        /// Indicates that the expected type was incorrect
        case typeError
    }
    
    /// Records a value that may be compared against an expectation, providing a useful failure
    /// message for ease of debugging
    func expect<T>(_ actual: T, file: StaticString? = nil, line: UInt? = nil) -> Actual<T> {
        return Actual(value: actual)
    }
    
    /// A wrapper for non-optional values, allowing expectations to be tested upon them
    struct Actual<T> {
        let value: T
        
        /// Returns the object cast as the new type, failing the test if the cast fails
        func `as`<ExpectedType>(_ type: ExpectedType.Type, file: StaticString = #file, line: UInt = #line) throws -> ExpectedType {
            if let typedValue = value as? ExpectedType {
                return typedValue
            } else {
                XCTFail("Expected value of type \(type), but was type \(T.self)", file: file, line: line)
                throw ExpectationError.typeError
            }
        }
    }
    
    /// Records a value that may be compared against an expectation, providing a useful failure
    /// message for ease of debugging
    func expect<T>(_ maybe: Optional<T>, file: StaticString? = nil, line: UInt? = nil) -> Maybe<T> {
        return Maybe(value: maybe)
    }
    
    /// A wrapper for optional values, allowing expectations to be tested upon them
    struct Maybe<T> {
        let value: T?
        
        /// Passes the test if the value is nil
        func isNil(file: StaticString = #file, line: UInt = #line) {
            if let value = value {
                XCTFail("Expected nil, but was \(value)", file: file, line: line)
            }
        }
        
        /// Passes the test if the value is not nil
        func isNotNil(file: StaticString = #file, line: UInt = #line) {
            if value == nil {
                XCTFail("Expected not nil, but was.", file: file, line: line)
            }
        }
    }
}

extension XCTestCase.Actual where T: Equatable {
    /// Asserts that the actual value is equal to the expected value, and fails the test at
    /// the call site if the expectation is violated, providing a helpful summary.
    func `is`(_ expectedValue: T, file: StaticString = #file, line: UInt = #line) {
        if value != expectedValue {
            XCTFail("Expected \(expectedValue) but was \(value)", file: file, line: line)
        }
    }
    
    /// Asserts that the actual value is not equal to the expected value, and fails the test at
    /// the call site if the expectation is violated, providing a helpful summary.
    func isNot(_ expectedValue: T, file: StaticString = #file, line: UInt = #line) {
        if value == expectedValue {
            XCTFail("Expected value was not \(expectedValue), but was", file: file, line: line)
        }
    }
}

extension XCTestCase.Actual where T: AnyObject {
    /// Asserts that the object is not the same as the expected object, and fails the test at
    /// the call site if the expectation is violated, providing a helpful summary.
    func isSameObject(as expectedValue: T, file: StaticString = #file, line: UInt = #line) {
        if value !== expectedValue {
            XCTFail("Expected \(expectedValue) but was \(value)", file: file, line: line)
        }
    }
    
    /// Asserts that the object is the same as the expected object, and fails the test at
    /// the call site if the expectation is violated, providing a helpful summary.
    func isNot(_ expectedValue: T, file: StaticString = #file, line: UInt = #line) {
        if value === expectedValue {
            XCTFail("Expected value was not \(expectedValue), but was", file: file, line: line)
        }
    }
}
