//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by sei on 2023/01/17.
//

import XCTest

final class CalculatorTests: XCTestCase {

    var sut: CalculatorItemQueue!

    override func setUpWithError() throws {
        sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_초기화했을때_isEmpty_true() throws {
        XCTAssertTrue(sut.isEmpty)
    }

}
