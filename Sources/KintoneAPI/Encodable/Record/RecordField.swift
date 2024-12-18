//
//  RecordField.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

import Foundation

public struct RecordField: Encodable, Sendable {
    public var code: String
    public var value: RecordFieldValue

    public init(code: String, value: RecordFieldValue) {
        self.code = code
        self.value = value
    }

    enum CodingKeys: CodingKey {
        case value
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch value {
        case let .checkBox(stringArray):
            try container.encode(stringArray, forKey: .value)
        case let .date(date):
            let dateString = DateFormatter.kintoneDate.string(from: date)
            try container.encode(dateString, forKey: .value)
        case let .dateTime(date):
            let dateString = DateFormatter.kintoneDateTime.string(from: date)
            try container.encode(dateString, forKey: .value)
        case let .dropDown(stringArray):
            try container.encode(stringArray, forKey: .value)
        case let .file(fileArray):
            try container.encode(fileArray, forKey: .value)
        case let .groupSelect(codeArray):
            try container.encode(codeArray, forKey: .value)
        case let .link(string):
            try container.encode(string, forKey: .value)
        case let .multiLineText(string):
            try container.encode(string, forKey: .value)
        case let .multiSelect(stringArray):
            try container.encode(stringArray, forKey: .value)
        case let .number(string):
            try container.encode(string, forKey: .value)
        case let .organizationSelect(codeArray):
            try container.encode(codeArray, forKey: .value)
        case let .radioButton(string):
            try container.encode(string, forKey: .value)
        case let .richText(string):
            try container.encode(string, forKey: .value)
        case let .singleLineText(string):
            try container.encode(string, forKey: .value)
        case let .time(time):
            try container.encode(time, forKey: .value)
        case let .userSelect(codeArray):
            try container.encode(codeArray, forKey: .value)
        }
    }
}
