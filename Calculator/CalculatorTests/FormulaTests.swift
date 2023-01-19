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

    func test_Formula가_비어있을때_result호출시_에러() throws {
        XCTAssertThrowsError(try sut.result())
    }

    func test_0으로_나눌때_에러() throws {
        let operand1 = 1.0
        let operand2 = 0.0
        sut.operands.enqueue(item: operand1)
        sut.operands.enqueue(item: operand2)

        let operator1 = Operator.divide
        sut.operators.enqueue(item: operator1)

        do {
            let result = try sut.result()
            XCTAssertThrowsError(result)
        } catch let error as FormulaError {
            XCTAssertEqual(error, .dividedByZero)
        }
    }

    func test_0으로_뺄때_에러아님() throws {
        let operand1 = 1.0
        let operand2 = 0.0
        sut.operands.enqueue(item: operand1)
        sut.operands.enqueue(item: operand2)

        let operator1 = Operator.subtract
        sut.operators.enqueue(item: operator1)

        XCTAssertNoThrow(try sut.result())
    }

    func test_operands_6개_operator_5개_result() throws {
        let operands = [1.0, 2.0, 3.0, 2.0, 3.0, 6.0]
        operands.forEach { number in
            sut.operands.enqueue(item: number)
        }

        let operators: [Operator] = [.add, .subtract, .multiply, .subtract, .divide]
        operators.forEach { `operator` in
            sut.operators.enqueue(item: `operator`)
        }

        XCTAssertEqual(try? sut.result(), -0.5)
    }

    func test_0으로_나눌때_에러_인자가_많은_경우() throws {
        let operands = [1.0, 0.0, 3.0, 4.0, 5.0]
        let operators: [Operator] = [.divide, .add, .multiply, .subtract]
        sut = Formula(operands: operands, operators: operators)

        do {
            let result = try sut.result()
            XCTAssertThrowsError(result)
        } catch let error as FormulaError {
            XCTAssertEqual(error, .dividedByZero)
        }
    }

}
