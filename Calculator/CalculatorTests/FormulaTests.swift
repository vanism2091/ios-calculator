//
//  FormulaTests.swift
//  CalculatorTests
//
//  Created by sei on 2023/01/17.
//

import XCTest
@testable import Calculator

final class FormulaTests: XCTestCase {
    var sut: Formula!

    override func setUpWithError() throws {
        sut = Formula()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_Formula_초기화하면_두_큐_isEmpty_true() throws {
        XCTAssertTrue(sut.operands.isEmpty)
        XCTAssertTrue(sut.operators.isEmpty)
    }

    func test_Formula가_비어있을때_result는_0이다() throws {
        XCTAssertEqual(try? sut.result(), 0.0)
    }

    func test_operands가_1_2이고_operator가_add일때_result는_3이다() throws {
        let operand1 = 1.0
        let operand2 = 2.0
        sut.operands.enqueue(item: operand1)
        sut.operands.enqueue(item: operand2)

        let operator1 = Operator.add
        sut.operators.enqueue(item: operator1)

        XCTAssertEqual(try? sut.result(), 3.0)
    }

    func test_Formula의_operands가_operator_보다_1개_많지_않으면_에러() throws {
        let operand1 = 1.0
        sut.operands.enqueue(item: operand1)

        let operator1 = Operator.add
        sut.operators.enqueue(item: operator1)

        XCTAssertThrowsError(try sut.result())
    }
}
