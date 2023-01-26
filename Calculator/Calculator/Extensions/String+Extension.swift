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
        guard self.contains(target) else { return [self] }

        return self.components(separatedBy: separator)
            .flatMap { [$0, separator] }
            .dropLast()
            .filter { $0 != "" }
    }

    func appendingDigit(_ aString: String, by formatter: NumberFormatter) -> String {
        let newNumberString = self.replacingOccurrences(of: ",", with: "") + aString
        return formatter.string(for: Double(newNumberString)) ?? "0"
    }
}
