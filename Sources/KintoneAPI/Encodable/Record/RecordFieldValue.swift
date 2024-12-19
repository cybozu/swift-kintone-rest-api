//
//  RecordFieldValue.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

import Foundation

public enum RecordFieldValue: Encodable, Sendable {
    case checkBox([String])
    case date(Date)
    case dateTime(Date)
    case dropDown(String)
    case file([FileObject])
    case groupSelect([CodeObject])
    case link(String)
    case multiLineText(String)
    case multiSelect([String])
    case number(String)
    case organizationSelect([CodeObject])
    case radioButton(String)
    case richText(String)
    case singleLineText(String)
    case time(Date)
    case userSelect([CodeObject])

    public static func defaultValue(fieldProperty: FieldProperty) -> RecordFieldValue? {
        switch fieldProperty.data {
        case let .checkBox(value):
            .checkBox(value.defaultValue)
        case let .date(value):
            .date(value.defaultValue)
        case let .dateTime(value):
            .dateTime(value.defaultValue)
        case let .dropDown(value):
            .dropDown(value.defaultValue)
        case let .groupSelect(value):
            .groupSelect(value.defaultValue.map({ CodeObject(code: $0.code) }))
        case let .link(value):
            .link(value.defaultValue)
        case let .multiLineText(value):
            .multiLineText(value.defaultValue)
        case let .multiSelect(value):
            .multiSelect(value.defaultValue)
        case let .number(value):
            .number(value.defaultValue)
        case let .organizationSelect(value):
            .organizationSelect(value.defaultValue.map({ CodeObject(code: $0.code) }))
        case let .radioButton(value):
            .radioButton(value.defaultValue)
        case let .richText(value):
            .richText(value.defaultValue)
        case let .singleLineText(value):
            .singleLineText(value.defaultValue)
        case let .time(value):
            .time(value.defaultValue)
        case let .userSelect(value):
            .userSelect(value.defaultValue.map({ CodeObject(code: $0.code) }))
        default:
            nil
        }
    }

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
        case let .multiSelect(value): value
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

    public var fileObjects: [FileObject]? {
        switch self {
        case let .file(value): value
        default: nil
        }
    }

    public var codeObjects: [CodeObject]? {
        switch self {
        case let .groupSelect(value): value
        case let .organizationSelect(value): value
        case let .userSelect(value): value
        default: nil
        }
    }
}
