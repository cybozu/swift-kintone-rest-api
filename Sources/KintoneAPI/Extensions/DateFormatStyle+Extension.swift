//
//  DateFormatStyle+Extension.swift
//
//
//  Created by elmetal on 2026/07/13.
//

import Foundation

extension Date.FormatStyle {
    static let kintoneDate = KintoneDateFormatStyle()
    static let kintoneDateTime = Date.ISO8601FormatStyle()
    static let kintoneTime = KintoneTimeFormatStyle()
}

struct KintoneDateFormatStyle: ParseableFormatStyle, ParseStrategy {
    private let calendar: Calendar
    private let verbatimStyle: Date.VerbatimFormatStyle

    init() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        self.calendar = calendar
        self.verbatimStyle = Date.VerbatimFormatStyle(
            format: "\(year: .padded(4))-\(month: .twoDigits)-\(day: .twoDigits)",
            timeZone: .autoupdatingCurrent,
            calendar: calendar
        )
    }

    var parseStrategy: Self { self }

    func format(_ value: Date) -> String {
        verbatimStyle.format(value)
    }

    func parse(_ value: String) throws -> Date {
        let parsed = try verbatimStyle.parseStrategy.parse(value)
        let time = calendar.dateComponents([.hour, .minute, .second], from: Date(timeIntervalSinceReferenceDate: .zero))
        guard let hour = time.hour,
              let minute = time.minute,
              let second = time.second,
              let date = calendar.date(bySettingHour: hour, minute: minute, second: second, of: parsed)
        else {
            throw CocoaError(.formatting)
        }
        return date
    }
}

struct KintoneTimeFormatStyle: ParseableFormatStyle, ParseStrategy {
    private let calendar: Calendar
    private let verbatimStyle: Date.VerbatimFormatStyle

    init() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        self.calendar = calendar
        self.verbatimStyle = Date.VerbatimFormatStyle(
            format: "\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits)",
            timeZone: .autoupdatingCurrent,
            calendar: calendar
        )
    }

    var parseStrategy: Self { self }

    func format(_ value: Date) -> String {
        verbatimStyle.format(value)
    }

    func parse(_ value: String) throws -> Date {
        let parsed = try verbatimStyle.parseStrategy.parse(value)
        let time = calendar.dateComponents([.hour, .minute], from: parsed)
        guard let hour = time.hour,
              let minute = time.minute,
              let date = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date(timeIntervalSinceReferenceDate: .zero))
        else {
            throw CocoaError(.formatting)
        }
        return date
    }
}
