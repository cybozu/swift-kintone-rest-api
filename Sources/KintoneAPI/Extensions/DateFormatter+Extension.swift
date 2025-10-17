//
//  DateFormatter+Extension.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

import Foundation

extension DateFormatter {
    static let kintoneDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = .current
        formatter.defaultDate = Date(timeIntervalSinceReferenceDate: .zero)
        return formatter
    }()

    static let kintoneDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    static let kintoneTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = .current
        formatter.defaultDate = Date(timeIntervalSinceReferenceDate: .zero)
        return formatter
    }()

    func date(fromOptional dateString: String?) -> Date? {
        if let dateString {
            date(from: dateString)
        } else {
            nil
        }
    }
}
