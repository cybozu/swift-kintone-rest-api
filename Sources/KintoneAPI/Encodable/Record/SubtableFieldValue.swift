//
//  SubtableFieldValue+Write.swift
//
//
//  Created by ky0me22 on 2025/12/19.
//

import Foundation

extension SubtableFieldValue {
    public enum Write: Encodable, Sendable {
        case checkbox([String])
        case date(Date?)
        case dateTime(Date?)
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
        case time(Date?)
        case userSelection([Entity.Write])

        enum CodingKeys: CodingKey {
            case type
            case value
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case let .checkbox(stringArray):
                try container.encode(RecordFieldType.checkbox, forKey: .type)
                try container.encode(stringArray, forKey: .value)
            case let .date(date):
                try container.encode(RecordFieldType.date, forKey: .type)
                let dateString = date.map { DateFormatter.kintoneDate.string(from: $0) }
                try container.encode(dateString, forKey: .value)
            case let .dateTime(date):
                try container.encode(RecordFieldType.dateTime, forKey: .type)
                let dateString = date.map { DateFormatter.kintoneDateTime.string(from: $0) }
                try container.encode(dateString, forKey: .value)
            case let .dropDown(string):
                try container.encode(RecordFieldType.dropDown, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .file(fileArray):
                try container.encode(RecordFieldType.file, forKey: .type)
                try container.encode(fileArray, forKey: .value)
            case let .groupSelection(entityArray):
                try container.encode(RecordFieldType.groupSelection, forKey: .type)
                try container.encode(entityArray, forKey: .value)
            case let .link(string):
                try container.encode(RecordFieldType.link, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .multiLineText(string):
                try container.encode(RecordFieldType.multiLineText, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .multiSelection(stringArray):
                try container.encode(RecordFieldType.multiSelection, forKey: .type)
                try container.encode(stringArray, forKey: .value)
            case let .number(string):
                try container.encode(RecordFieldType.number, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .organizationSelection(entityArray):
                try container.encode(RecordFieldType.organizationSelection, forKey: .type)
                try container.encode(entityArray, forKey: .value)
            case let .radioButton(string):
                try container.encode(RecordFieldType.radioButton, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .richText(string):
                try container.encode(RecordFieldType.richText, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .singleLineText(string):
                try container.encode(RecordFieldType.singleLineText, forKey: .type)
                try container.encode(string, forKey: .value)
            case let .time(date):
                try container.encode(RecordFieldType.time, forKey: .type)
                let dateString = date.map { DateFormatter.kintoneTime.string(from: $0) }
                try container.encode(dateString, forKey: .value)
            case let .userSelection(entityArray):
                try container.encode(RecordFieldType.userSelection, forKey: .type)
                try container.encode(entityArray, forKey: .value)
            }
        }
    }
}

extension SubtableFieldValue.Write {
    public init?(value: RecordFieldValue.Write) {
        switch value {
        case let .checkbox(value):
            self = .checkbox(value)
        case let .date(value):
            self = .date(value)
        case let .dateTime(value):
            self = .dateTime(value)
        case let .dropDown(value):
            self = .dropDown(value)
        case let .file(value):
            self = .file(value)
        case let .groupSelection(value):
            self = .groupSelection(value)
        case let .link(value):
            self = .link(value)
        case let .multiLineText(value):
            self = .multiLineText(value)
        case let .multiSelection(value):
            self = .multiSelection(value)
        case let .number(value):
            self = .number(value)
        case let .organizationSelection(value):
            self = .organizationSelection(value)
        case let .radioButton(value):
            self = .radioButton(value)
        case let .richText(value):
            self = .richText(value)
        case let .singleLineText(value):
            self = .singleLineText(value)
        case .subtable:
            return nil
        case let .time(value):
            self = .time(value)
        case let .userSelection(value):
            self = .userSelection(value)
        }
    }
}
