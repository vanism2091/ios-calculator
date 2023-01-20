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
        sut = Formula(operands: [1.0, 2.0], operators: [.add])
        XCTAssertEqual(try? sut.result(), 3.0)
    }

    func test_Formula의_operands가_operator_보다_1개_많지_않으면_에러() throws {
        sut = Formula(operands: [1.0], operators: [.add])
        XCTAssertThrowsError(try sut.result())
    }

    func test_Formula가_비어있을때_result호출시_에러() throws {
        XCTAssertThrowsError(try sut.result())
    }

    func test_0으로_나눌때_에러() throws {
        sut = Formula(operands: [1.0, 0.0], operators: [.divide])

        do {
            let result = try sut.result()
            XCTAssertThrowsError(result)
        } catch let error as FormulaError {
            XCTAssertEqual(error, .dividedByZero)
        }
    }

    func test_0으로_뺄때_에러아님() throws {
        sut = Formula(operands: [1.0, 0.0], operators: [.subtract])

        XCTAssertNoThrow(try sut.result())
    }

    func test_operands_6개_operator_5개_result() throws {
        let operands = [1.0, 2.0, 3.0, 2.0, 3.0, 6.0]
        let operators: [Operator] = [.add, .subtract, .multiply, .subtract, .divide]

        sut = Formula(operands: operands, operators: operators)

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
