//
//  Date+Extension.swift
//  Example
//
//  Created by ky0me22 on 2025/10/17.
//

import Foundation

extension Date {
    var onlyDateFormatted: String {
        formatted(Date.FormatStyle(date: .numeric, time: .omitted).month(.twoDigits).day(.twoDigits))
    }

    var dateAndTimeFormatted: String {
        formatted(Date.FormatStyle(date: .numeric, time: .standard).month(.twoDigits).day(.twoDigits))
    }

    var onlyTimeFormatted: String {
        formatted(Date.FormatStyle(date: .omitted, time: .standard))
    }
}
