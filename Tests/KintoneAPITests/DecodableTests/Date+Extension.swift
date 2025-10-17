import Foundation

extension Date {
    static let distantReferenceZero: Date = {
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!
    }()

    static let distantReferencePast: Date = {
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        return Calendar.current.date(byAdding: .year, value: -2000, to: referenceDate)!
    }()
}
