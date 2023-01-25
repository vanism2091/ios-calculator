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
        // Do any additional setup after loading the view.
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
        print(sender.currentTitle ?? "c")
    }

    @IBAction func signToggleDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "+-")
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "00.")
    }
}
