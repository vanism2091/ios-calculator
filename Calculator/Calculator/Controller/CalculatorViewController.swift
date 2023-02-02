//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    private enum Constant {
        static let zero = "0"
        static let doubleZero = "00"
        static let dot = "."
        static let allClear = "AC"
        static let clearEntry = "CE"
        static let NotANumber = "NaN"
        static let emptyString = ""
        static let comma = ","
        static let nine = "9"
    }

    @IBOutlet private weak var operatorLabel: UILabel!
    @IBOutlet private weak var entryNumberLabel: UILabel!
    @IBOutlet private weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet private weak var calculationHistoryContentView: UIStackView!

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()

    private let maxDigitLength = 15
    private var isDisplayNumberZeroOnly: Bool {
        displayNumber == Constant.zero
    }
    private var formulaString = Constant.emptyString
    private var isTypingNumber = false
    private var displayNumber: String = Constant.zero {
        willSet {
            guard let lastElement = newValue.last else {
                return
            }
            let lastCharacter = String(lastElement)
            switch lastCharacter {
            case Constant.dot:
                entryNumberLabel.text?.append(lastCharacter)
            case Constant.zero...Constant.nine:
                entryNumberLabel.text = parse(newValue)
            default:
                entryNumberLabel.text = newValue
            }
        }
    }
    private var displayOperator: String = Constant.emptyString {
        willSet {
            operatorLabel.text = newValue
        }
    }

    @IBAction private func digitButtonDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle, displayNumber.count < maxDigitLength else {
            return
        }
        if isTypingNumber {
            displayNumber += digit
        } else {
            displayNumber = digit
            isTypingNumber = true
        }
    }

    @IBAction private func arithmeticOperatorButtonDidTap(_ sender: UIButton) {
        if displayNumber == Constant.NotANumber {
            displayNumber = Constant.zero
        }
        guard let buttonTitle = sender.currentTitle else {
            return
        }
        if isTypingNumber || false == isDisplayNumberZeroOnly {
            addCalculationHistory()
        }
        displayOperator = buttonTitle
        clearEntry()
    }

    @IBAction private func equalsButtonDidTap(_ sender: UIButton) {
        guard false == displayOperator.isEmpty else {
            return
        }
        print(formulaString)
        addCalculationHistory()
        let result = calculationResult(from: formulaString)
        print(formulaString, result, displayNumber)
        displayNumber = result
        clearOperatorAndFormulaString()
        isTypingNumber = false
    }

    @IBAction private func clearButtonDidTap(_ sender: UIButton) {
        switch sender.currentTitle {
        case Constant.clearEntry:
            clearEntry()
        case Constant.allClear:
            clearAll()
        default:
            return
        }
    }

    @IBAction private func signToggleButtonDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              false == isDisplayNumberZeroOnly,
              let number = Double(displayNumber) else {
            return
        }
        displayNumber = String(number * -1)
    }

    @IBAction private func zeroOrPointButtonDidTap(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle,
              displayNumber.count < maxDigitLength else {
            return
        }

        switch buttonTitle {
        case Constant.zero, Constant.doubleZero:
            if isDisplayNumberZeroOnly {
                return
            }
            let suffix = (displayNumber + buttonTitle).count > maxDigitLength ? Constant.zero : buttonTitle
            displayNumber += suffix
        case Constant.dot:
            if displayNumber.contains(Constant.dot) {
                return
            }
            displayNumber += buttonTitle
            isTypingNumber = true
        default:
            return
        }
    }
}

extension CalculatorViewController {
    // MARK: CalculationResult
    private func calculationResult(from formula: String) -> String {
        let result = ExpressionParser.parse(from: formula).result()
        switch result {
        case .success(let res):
            return String(res)
        case .failure(let error):
            return error.description
        }
    }

    // MARK: Parse - numberFormat
    private func parse(_ value: String) -> String {
        let removedComma = value.replacingOccurrences(of: Constant.comma, with: Constant.emptyString)
        let nsNumber = numberFormatter.number(from: removedComma)
        return (numberFormatter.string(for: nsNumber) ?? Constant.zero)
    }

    // MARK: Add History
    private func addCalculationHistory() {
        let currOperator = formulaString.isEmpty ? Constant.emptyString : displayOperator
        appendHistoryStackView(operator: currOperator)
        formulaString += "\(currOperator)\(displayNumber)"
    }

    private func appendHistoryStackView(operator: String?) {
        let parsedNumber = parse(displayNumber)
        let stackView = HistoryStackView(operator: `operator`, operand: parsedNumber)
        calculationHistoryContentView.addArrangedSubview(stackView)

        view.layoutIfNeeded()
        calculationHistoryScrollView.scrollToBottom()
    }

    // MARK: Clear
    private func clearEntry() {
        displayNumber = Constant.zero
        isTypingNumber = false
    }

    private func clearOperatorAndFormulaString() {
        displayOperator = Constant.emptyString
        formulaString = Constant.emptyString
    }

    private func clearAll() {
        clearEntry()
        clearOperatorAndFormulaString()
        calculationHistoryContentView.removeAllHistorySubviews()
    }
}
