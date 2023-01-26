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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle,
              let label = entryNumberLabel.text else { return }
        if isEntryNumberZeroOnly {
            entryNumberLabel.text = digit
        } else if label.count < maxDigitLength {
            entryNumberLabel.text?.append(digit)
        }
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        if false == isEntryNumberZeroOnly,
           let currentNumber = entryNumberLabel.text {
            appendCalculationHistory(operator: operatorLabel.text, number: currentNumber)
        }
        operatorLabel.text = sender.currentTitle
        clearEntry()
    }

    @IBAction func equalsDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "==")
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
              let currentNumberString = entryNumberLabel.text,
              let currentNumber = Double(currentNumberString) else { return }
        entryNumberLabel.text = String(currentNumber * -1)
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonName = sender.currentTitle,
              let currentNumber = entryNumberLabel.text,
              currentNumber.count < maxDigitLength else { return }

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

    private func buildDisplayLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        return label
    }
}

// MARK: Clear
extension CalculatorViewController {
    private func clearEntry() {
        entryNumberLabel.text = Constant.zero
    }

    private func clearAll() {
        entryNumberLabel.text = Constant.zero
        operatorLabel.text = nil
        // contentView remove subviews
    }
}
