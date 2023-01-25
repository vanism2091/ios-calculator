//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var currentNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCurrentDisplay()
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle,
              let label = currentNumberLabel.text else { return }
        if currentNumberLabel.text == "0" {
            currentNumberLabel.text = digit
        } else if label.count < 20 {
            currentNumberLabel.text?.append(digit)
        }
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        operationLabel.text = sender.currentTitle
    }

    @IBAction func equalsDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "==")
    }

    @IBAction func clearDidTap(_ sender: UIButton) {
        initializeCurrentDisplay()
        if sender.currentTitle == "AC" {
            // clear history
        }
    }

    // TODO: - Int 말고 Double
    @IBAction func signToggleDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              let currentNumberString = currentNumberLabel.text,
              let currentNumber = Int(currentNumberString) else { return }
        currentNumberLabel.text = String(currentNumber * -1)
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonName = sender.currentTitle,
              let currentNumber = currentNumberLabel.text,
              currentNumber.count < 20 else { return }

        switch buttonName {
        case "0":
            guard currentNumber != "0" else { return }
            currentNumberLabel.text?.append(buttonName)
        case "00":
            guard currentNumber != "0" else { return }
            currentNumberLabel.text?.append(buttonName)
            if let number = currentNumberLabel.text, number.count > 20 {
                currentNumberLabel.text?.removeLast()
            }
        case ".":
            guard false == currentNumberLabel.text?.contains(".") else { return }
            currentNumberLabel.text?.append(buttonName)
        default:
            return
        }
    }

    private func initializeCurrentDisplay() {
        operationLabel.text = nil
        currentNumberLabel.text = "0"
    }
}
