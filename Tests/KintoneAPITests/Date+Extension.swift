import Foundation

extension Date {
    private static let calendar = Calendar(identifier: .gregorian)

    static let distantReferenceZero: Date = {
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!
    }()

    static let distantReferencePast: Date = {
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        return calendar.date(byAdding: .year, value: -2000, to: referenceDate)!
    }()
}
