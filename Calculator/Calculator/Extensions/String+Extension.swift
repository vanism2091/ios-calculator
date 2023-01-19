//
//  String+Extension.swift
//  Calculator
//
//  Created by jun on 2023/01/19.
//

import Foundation

extension String {
    func split(with target: Character) -> [String] {
        let separator = String(target)
        return self.components(separatedBy: separator)
            .flatMap { [$0, separator] }
            .dropLast()
            .filter { $0 != "" }
    }
}
