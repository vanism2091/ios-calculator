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

    func test_parse에_3더하기4_넣으면_Operands에_3_4_Operators에_더하기_있다() {
        var formula = ExpressionParser.parse(from: "3\(Operator.add.rawValue)4")

        guard let currentOperator = formula.operators.dequeue() as? Operator else {
            XCTFail("operator가 아님")
            return
        }
        XCTAssertTrue(currentOperator.rawValue == Operator.add.rawValue
        )
        XCTAssertTrue(formula.operators.isEmpty)

        guard let num1 = formula.operands.dequeue() as? Double,
              let num2 = formula.operands.dequeue() as? Double else {
            XCTFail("double이 아님")
            return
        }
        XCTAssertTrue(num1 == 3.0)
        XCTAssertTrue(num2 == 4.0)
        XCTAssertTrue(formula.operands.isEmpty)

    }

    func test_모든연산자기준으로_양의정수를_split한다() throws {
        let given = "2+3−4×5×6÷3"
        let result = ExpressionParser.componentsByOperators(from: given)
        let expected = ["2", "+", "3", "−", "4", "×", "5", "×", "6", "÷", "3"]
        XCTAssertEqual(result, expected)
    }

    func test_모든연산자기준으로_음의정수를_split한다() throws {
        let given = "-2+-3−-4×-5×-6÷-3"
        let result = ExpressionParser.componentsByOperators(from: given)
        let expected = ["-2", "+", "-3", "−", "-4", "×", "-5", "×", "-6", "÷", "-3"]
        XCTAssertEqual(result, expected)
    }
}
