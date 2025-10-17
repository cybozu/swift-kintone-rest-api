import Foundation

extension Date {
    static let distantReferenceZero: Date = {
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!
    }()
}
