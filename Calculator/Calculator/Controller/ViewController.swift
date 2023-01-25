//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "-")
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "사칙연산")
    }

    @IBAction func equalsDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "==")
    }

    @IBAction func clearDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "c")
    }

}
