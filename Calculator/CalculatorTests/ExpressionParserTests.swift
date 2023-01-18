//
//  ExpressionParserTests.swift
//  CalculatorTests
//
//  Created by jun on 2023/01/18.
//

import XCTest
@testable import Calculator

final class ExpressionParserTests: XCTestCase {
    func test_parse에_빈문자열을_넣으면_빈_Formula를_반환한다() throws {
        let formula: Formula = ExpressionParser.parse(from: "")

        XCTAssertTrue(formula.operands.isEmpty)
        XCTAssertTrue(formula.operators.isEmpty)
    }

}
