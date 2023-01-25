//
//  CalculatorModelTests.swift
//  CalculatorTests
//
//  Created by jun on 2023/01/20.
//

import XCTest
@testable import Calculator

final class CalculatorModelTests: XCTestCase {
    func test_통합테스트1() throws {
        let result = try? ExpressionParser.parse(from: "10.1+12.5÷127+8−100×13.8").result()
        let expected = -1_267.144251968503937
        XCTAssertEqual(result, expected)
    }

    func test_통합테스트2() throws {
        let result = try? ExpressionParser.parse(from: "2+3×3−1").result()
        let expected: Double = 14
        XCTAssertEqual(result, expected)
    }

    func test_통합테스트3() throws {
        let result = try? ExpressionParser.parse(from: "3÷3+2−1").result()
        let expected: Double = 2
        XCTAssertEqual(result, expected)
     }

    func test_통합테스트4() throws {
        let result = try? ExpressionParser.parse(from: "1+2−3×2−3÷6").result()
        let expected: Double = -0.5
        XCTAssertEqual(result, expected)
    }
}
