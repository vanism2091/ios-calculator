//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    enum Constant {
        static let zero = "0"
        static let doubleZero = "00"
        static let dot = "."
        static let allClear = "AC"
        static let clearEntry = "CE"
    }

    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var entryNumberLabel: UILabel!
    @IBOutlet weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet weak var calculationHistoryContentView: UIStackView!

    let maxDigitLength = 20
    var isEntryNumberZeroOnly: Bool {
        entryNumberLabel.text == Constant.zero
    }
    var formulaString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle,
              let label = entryNumberLabel.text else { return }
        if isEntryNumberZeroOnly || operatorLabel.text == nil {
            entryNumberLabel.text = digit
        } else if label.count < maxDigitLength {
            entryNumberLabel.text?.append(digit)
        }
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        if false == isEntryNumberZeroOnly,
           let number = entryNumberLabel.text {
            let `operator` = formulaString.isEmpty ? nil : operatorLabel.text
            appendCalculationHistory(operator: `operator`, number: number)
            formulaString += "\(`operator` ?? "")\(number)"
        }
        operatorLabel.text = sender.currentTitle
        clearEntry()
    }

    @IBAction func equalsDidTap(_ sender: UIButton) {
        if let `operator` = operatorLabel.text, let number = entryNumberLabel.text {
            appendCalculationHistory(operator: `operator`, number: number)
            formulaString += "\(`operator`)\(number)"
            let result = calculationResult(from: formulaString)
            entryNumberLabel.text = result
            clearOperatorAndFormulaString()
        }
    }

    @IBAction func clearDidTap(_ sender: UIButton) {
        switch sender.currentTitle {
        case Constant.clearEntry:
            clearEntry()
        case Constant.allClear:
            clearAll()
        default:
            return
        }
    }

    @IBAction func signToggleDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              false == isEntryNumberZeroOnly,
              let numberString = entryNumberLabel.text,
              let number = Double(numberString) else { return }
        entryNumberLabel.text = String(number * -1)
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonName = sender.currentTitle,
              let number = entryNumberLabel.text,
              number.count < maxDigitLength else { return }

        switch buttonName {
        case Constant.zero, Constant.doubleZero:
            if isEntryNumberZeroOnly { return }
            entryNumberLabel.text?.append(buttonName)
            if let number = entryNumberLabel.text, number.count > maxDigitLength {
                entryNumberLabel.text?.removeLast()
            }
        case Constant.dot:
            guard false == entryNumberLabel.text?.contains(Constant.dot) else { return }
            entryNumberLabel.text?.append(buttonName)
        default:
            return
        }
    }

    private func appendCalculationHistory(operator: String?, number: String) {
        let stackView = HistoryStackView(operator: `operator`, operand: number)
        calculationHistoryContentView.addArrangedSubview(stackView)

        view.layoutIfNeeded()
        calculationHistoryScrollView.scrollToBottom()
    }
}

// MARK: Clear
extension CalculatorViewController {
    private func clearEntry() {
        entryNumberLabel.text = Constant.zero
    }

    private func clearOperatorAndFormulaString() {
        operatorLabel.text = nil
        formulaString = ""
    }

    private func clearAll() {
        clearEntry()
        clearOperatorAndFormulaString()
        //TODO: contentView remove subviews
    }
}

// MARK: calculationResult
extension CalculatorViewController {
    private func calculationResult(from formula: String) -> String {
        let result = ExpressionParser.parse(from: formula).result()
        switch result {
        case .success(let res):
            return String(res)
        case .failure(let error):
            return error.description
        }
    }
}
