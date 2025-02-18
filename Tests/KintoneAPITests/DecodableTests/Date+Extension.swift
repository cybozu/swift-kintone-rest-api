import Foundation

extension Date {
    static let distantReference: Date = {
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        return Calendar(identifier: .iso8601).date(byAdding: .year, value: -1, to: referenceDate)!
    }()
}
