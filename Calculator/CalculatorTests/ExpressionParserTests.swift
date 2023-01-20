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

        XCTAssertEqual(formula, Formula())
    }

    func test_parse에_3더하기4_넣으면_Operands에_3_4_Operators에_더하기_있다() {
        var formula = ExpressionParser.parse(from: "3\(Operator.add.rawValue)4")

        guard let currentOperator = formula.operators.dequeue() else {
            XCTFail("operator가 아님")
            return
        }
        XCTAssertTrue(currentOperator.rawValue == Operator.add.rawValue
        )
        XCTAssertTrue(formula.operators.isEmpty)

        guard let num1 = formula.operands.dequeue(),
              let num2 = formula.operands.dequeue() else {
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

    func test_parse로_반환된_Formula에_operators_operands가_제대로_분리되었다() throws {
        let given = "10.1+12.5÷127+8−100×13.8"
        var formula = ExpressionParser.parse(from: given)
        let operands: [Double] = [10.1, 12.5, 127, 8, 100, 13.8]
        let operators: [Operator] = [.add, .divide, .add, .subtract, .multiply]
        _ = Formula(operands: operands, operators: operators)

        for index in 0..<formula.operators.count {
            let dequed = formula.operators.dequeue()
            XCTAssertEqual(operators[index], dequed)
        }
        for index in 0..<formula.operands.count {
            let dequed = formula.operands.dequeue()
            XCTAssertEqual(operands[index], dequed)
        }
    }

    func test_parse로_반환된_Formula에_operators_operands가_제대로_분리되었다2() throws {
        let given = "10.1+12.5÷127+8−100×13.8"
        let formula = ExpressionParser.parse(from: given)
        let operands: [Double] = [10.1, 12.5, 127, 8, 100, 13.8]
        let operators: [Operator] = [.add, .divide, .add, .subtract, .multiply]
        let expected = Formula(operands: operands, operators: operators)

        XCTAssertEqual(formula, expected)
    }
}
