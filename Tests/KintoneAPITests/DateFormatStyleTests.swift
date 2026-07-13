import Foundation
import Testing

@testable import KintoneAPI

struct DateFormatStyleTests {
    // MARK: kintoneDate

    @Test
    func kintoneDate_format() {
        #expect(Date.distantReferencePast.formatted(Date.FormatStyle.kintoneDate) == "0001-01-01")
    }

    @Test
    func kintoneDate_parse() throws {
        let actual = try Date.FormatStyle.kintoneDate.parse("0001-01-01")
        #expect(actual == .distantReferencePast)
    }

    @Test(arguments: ["", "dummy", "2024-12"])
    func kintoneDate_parse_invalidString(_ value: String) {
        #expect(throws: (any Error).self) {
            try Date.FormatStyle.kintoneDate.parse(value)
        }
    }

    @Test
    func kintoneDate_roundTrip() throws {
        let actual = try Date.FormatStyle.kintoneDate.parse("2024-12-06")
        #expect(actual.formatted(Date.FormatStyle.kintoneDate) == "2024-12-06")
    }

    // MARK: kintoneDateTime

    @Test
    func kintoneDateTime_format() {
        #expect(Date.distantPast.formatted(Date.FormatStyle.kintoneDateTime) == "0001-01-01T00:00:00Z")
    }

    @Test
    func kintoneDateTime_parse() throws {
        let actual = try Date.FormatStyle.kintoneDateTime.parse("0001-01-01T00:00:00Z")
        #expect(actual == .distantPast)
    }

    @Test(arguments: ["", "dummy", "2024-12-06"])
    func kintoneDateTime_parse_invalidString(_ value: String) {
        #expect(throws: (any Error).self) {
            try Date.FormatStyle.kintoneDateTime.parse(value)
        }
    }

    @Test
    func kintoneDateTime_roundTrip() throws {
        let actual = try Date.FormatStyle.kintoneDateTime.parse("2024-12-06T10:30:00Z")
        #expect(actual.formatted(Date.FormatStyle.kintoneDateTime) == "2024-12-06T10:30:00Z")
    }

    // MARK: kintoneTime

    @Test
    func kintoneTime_format() {
        #expect(Date.distantReferenceZero.formatted(Date.FormatStyle.kintoneTime) == "00:00")
    }

    @Test
    func kintoneTime_parse() throws {
        let actual = try Date.FormatStyle.kintoneTime.parse("00:00")
        #expect(actual == .distantReferenceZero)
    }

    @Test(arguments: ["", "dummy", "0930"])
    func kintoneTime_parse_invalidString(_ value: String) {
        #expect(throws: (any Error).self) {
            try Date.FormatStyle.kintoneTime.parse(value)
        }
    }

    @Test
    func kintoneTime_roundTrip() throws {
        let actual = try Date.FormatStyle.kintoneTime.parse("10:30")
        #expect(actual.formatted(Date.FormatStyle.kintoneTime) == "10:30")
    }
}
