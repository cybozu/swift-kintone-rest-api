//
//  RecordFieldValue+Write.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

import Foundation

extension RecordFieldValue {
    public enum Write: Encodable, Sendable {
        case checkBox([String])
        case date(Date)
        case dateTime(Date)
        case dropDown(String?)
        case file([File.Write])
        case groupSelection([Entity.Write])
        case link(String)
        case multiLineText(String)
        case multiSelection([String])
        case number(String)
        case organizationSelection([Entity.Write])
        case radioButton(String)
        case richText(String)
        case singleLineText(String)
        case time(Date)
        case userSelection([Entity.Write])

        enum CodingKeys: CodingKey {
            case value
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
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
            case let .groupSelection(entityArray):
                try container.encode(entityArray, forKey: .value)
            case let .link(string):
                try container.encode(string, forKey: .value)
            case let .multiLineText(string):
                try container.encode(string, forKey: .value)
            case let .multiSelection(stringArray):
                try container.encode(stringArray, forKey: .value)
            case let .number(string):
                try container.encode(string, forKey: .value)
            case let .organizationSelection(entityArray):
                try container.encode(entityArray, forKey: .value)
            case let .radioButton(string):
                try container.encode(string, forKey: .value)
            case let .richText(string):
                try container.encode(string, forKey: .value)
            case let .singleLineText(string):
                try container.encode(string, forKey: .value)
            case let .time(date):
                let dateString = DateFormatter.kintoneTime.string(from: date)
                try container.encode(dateString, forKey: .value)
            case let .userSelection(entityArray):
                try container.encode(entityArray, forKey: .value)
            }
        }
    }
}

extension RecordFieldValue.Write {
    public var string: String? {
        switch self {
        case let .dropDown(value): value
        case let .link(value): value
        case let .multiLineText(value): value
        case let .number(value): value
        case let .radioButton(value): value
        case let .richText(value): value
        case let .singleLineText(value): value
        default: nil
        }
    }

    public var strings: [String]? {
        switch self {
        case let .checkBox(value): value
        case let .multiSelection(value): value
        default: nil
        }
    }

    public var date: Date? {
        switch self {
        case let .date(value): value
        case let .dateTime(value): value
        case let .time(value): value
        default: nil
        }
    }

    public var file: [File.Write]? {
        switch self {
        case let .file(value): value
        default: nil
        }
    }

    public var entities: [Entity.Write]? {
        switch self {
        case let .groupSelection(value): value
        case let .organizationSelection(value): value
        case let .userSelection(value): value
        default: nil
        }
    }
}
