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
        XCTAssertEqual(sut.result(), 0.0)
    }

}
