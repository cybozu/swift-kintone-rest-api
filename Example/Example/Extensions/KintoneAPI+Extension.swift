//
//  KintoneAPI+Extension.swift
//  Example
//
//  Created by ky0me22 on 2025/01/21.
//

import KintoneAPI

extension KintoneApp: @retroactive Identifiable {
    public var id: Int { appID }
}

extension Field: @retroactive Identifiable {
    public var id: String { code }
}

extension FieldOption: @retroactive Identifiable {
    public var id: Int { index }
}

extension Entity.Read: @retroactive Identifiable {
    public var id: String { code }
}

extension RecordField.Read: @retroactive Identifiable {
    public var id: String { code }
}

extension RecordField.Write: @retroactive Identifiable {
    public var id: String { code }
}

extension File.Read: @retroactive Identifiable {
    public var id: String { fileKey }
}

extension RecordState: @retroactive Identifiable {
    public var id: String { name }
}

extension StatusAction: @retroactive Identifiable {
    public var id: String { name }
}

extension RecordComment.Read: @retroactive Identifiable {}


extension FieldAttribute {
    var recordFieldValue: RecordFieldValue.Write? {
        switch self {
        case let .checkbox(value):
            return .checkbox(value.defaultValue)
        case let .date(value):
            return .date(value.defaultValue)
        case let .dateTime(value):
            return .dateTime(value.defaultValue)
        case let .dropDown(value):
            return .dropDown(value.defaultValue.isEmpty ? nil : value.defaultValue)
        case let .groupSelection(value):
            return .groupSelection(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
        case let .link(value):
            return .link(value.defaultValue)
        case let .multiLineText(value):
            return .multiLineText(value.defaultValue)
        case let .multiSelection(value):
            return .multiSelection(value.defaultValue)
        case let .number(value):
            return .number(value.defaultValue)
        case let .organizationSelection(value):
            return .organizationSelection(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
        case let .radioButton(value):
            return .radioButton(value.defaultValue)
        case let .richText(value):
            return .richText(value.defaultValue)
        case let .singleLineText(value):
            return .singleLineText(value.defaultValue)
        case let .subtable(value):
            let recordFields = value.fields.compactMap { field -> RecordField.Write? in
                guard let value = field.attribute.recordFieldValue else { return nil }
                return RecordField.Write(code: field.code, value: value)
            }
            return .subtable([recordFields])
        case let .time(value):
            return .time(value.defaultValue)
        case let .userSelection(value):
            return .userSelection(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
        default:
            return nil
        }
    }
}
