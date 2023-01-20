//
//  StringExtensionTests.swift
//  CalculatorTests
//
//  Created by jun on 2023/01/19.
//

import XCTest
@testable import Calculator

final class StringExtensionTests: XCTestCase {

    func test_더하기기호를_기준으로_split하면_더하기기호를_포함하여_나눠진다() throws {
        let given = "2+3-4*5+6"
        let result = given.split(with: "+")
        let expected = ["2", "+", "3-4*5", "+", "6"]
        XCTAssertEqual(result, expected)
    }
}
