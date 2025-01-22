//
//  SubmitRecordView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct SubmitRecordView: View {
    var fields: [FieldProperty]
    var onSubmitHandler: ([String: RecordFieldValue.Write]) -> Void
    @State private var fieldValues: [String: RecordFieldValue.Write]

    init(fields: [FieldProperty], onSubmitHandler: @escaping ([String: RecordFieldValue.Write]) -> Void) {
        self.fields = fields
        self.onSubmitHandler = onSubmitHandler
        self.fieldValues = fields.reduce(into: [String: RecordFieldValue.Write]()) {
            $0[$1.code] = switch $1.attribute {
            case let .checkBox(value):
                RecordFieldValue.Write.checkBox(value.defaultValue)
            case let .date(value):
                RecordFieldValue.Write.date(value.defaultValue)
            case let .dateTime(value):
                RecordFieldValue.Write.dateTime(value.defaultValue)
            case let .dropDown(value):
                RecordFieldValue.Write.dropDown(value.defaultValue)
            case let .groupSelect(value):
                RecordFieldValue.Write.groupSelect(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
            case let .link(value):
                RecordFieldValue.Write.link(value.defaultValue)
            case let .multiLineText(value):
                RecordFieldValue.Write.multiLineText(value.defaultValue)
            case let .multiSelect(value):
                RecordFieldValue.Write.multiSelect(value.defaultValue)
            case let .number(value):
                RecordFieldValue.Write.number(value.defaultValue)
            case let .organizationSelect(value):
                RecordFieldValue.Write.organizationSelect(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
            case let .radioButton(value):
                RecordFieldValue.Write.radioButton(value.defaultValue)
            case let .richText(value):
                RecordFieldValue.Write.richText(value.defaultValue)
            case let .singleLineText(value):
                RecordFieldValue.Write.singleLineText(value.defaultValue)
            case let .time(value):
                RecordFieldValue.Write.time(value.defaultValue)
            case let .userSelect(value):
                RecordFieldValue.Write.userSelect(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
            default:
                nil
            }
        }
    }

    var body: some View {
        Form {
            Section {
                ForEach(fields) { field in
                    RecordFieldView(field: field, fieldValues: $fieldValues)
                }
            }
            Section {
                LabeledContent {
                    Button {
                        onSubmitHandler(fieldValues)
                    } label: {
                        Text("Submit")
                    }
                    .buttonStyle(.borderedProminent)
                } label: {
                    EmptyView()
                }
            }
        }
    }
}

private struct RecordFieldView: View {
    var field: FieldProperty
    @Binding var fieldValues: [String: RecordFieldValue.Write]
    
    var body: some View {
        switch field.type {
        case .richText:
            if case let .richText(attribute) = field.attribute {
                LabeledContent {
                    TextField(
                        text: Binding<String>(
                            get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                            set: { fieldValues[field.code] = .richText($0) }
                        ),
                        label: { Text(attribute.defaultValue) }
                    )
                    .multilineTextAlignment(.trailing)
                } label: {
                    Text(field.label)
                }
            }
        case .multiLineText:
            if case let .multiLineText(attribute) = field.attribute {
                LabeledContent {
                    TextField(
                        text: Binding<String>(
                            get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                            set: { fieldValues[field.code] = .multiLineText($0) }
                        ),
                        label: { Text(attribute.defaultValue) }
                    )
                    .multilineTextAlignment(.trailing)
                } label: {
                    Text(field.label)
                }
            }
        case .singleLineText:
            if case let .singleLineText(attribute) = field.attribute {
                LabeledContent {
                    TextField(
                        text: Binding<String>(
                            get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                            set: { fieldValues[field.code] = .singleLineText($0) }
                        ),
                        label: { Text(attribute.defaultValue) }
                    )
                    .multilineTextAlignment(.trailing)
                } label: {
                    Text(field.label)
                }
            }
        case .number:
            if case let .number(attribute) = field.attribute {
                LabeledContent {
                    TextField(
                        text: Binding<String>(
                            get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                            set: { fieldValues[field.code] = .number($0.description) }
                        ),
                        label: { Text(attribute.defaultValue) }
                    )
                    .multilineTextAlignment(.trailing)
                } label: {
                    Text(field.label)
                }
            }
        case .link:
            if case let .link(attribute) = field.attribute {
                LabeledContent {
                    TextField(
                        text: Binding<String>(
                            get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                            set: { fieldValues[field.code] = .link($0) }
                        ),
                        label: { Text(attribute.defaultValue) }
                    )
                    .multilineTextAlignment(.trailing)
                } label: {
                    Text(field.label)
                }
            }
        case .radioButton:
            if case let .radioButton(attribute) = field.attribute {
                Picker(
                    selection: Binding<String>(
                        get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                        set: { fieldValues[field.code] = .radioButton($0) }
                    ),
                    content: {
                        ForEach(attribute.options) { option in
                            Text(option.label).tag(option.label)
                        }
                    },
                    label: { Text(field.label) }
                )
            }
        case .checkBox:
            if case let .checkBox(attribute) = field.attribute {
                Checkboxes(
                    axis: .vertical,
                    selection: Binding<Set<String>>(
                        get: { .init(fieldValues[field.code]?.strings ?? attribute.defaultValue) },
                        set: { fieldValues[field.code] = .checkBox($0.map({ $0 })) }
                    ),
                    content: {
                        ForEach(attribute.options) { option in
                            Text(option.label).tag(option.label)
                        }
                    },
                    label: { Text(field.label) }
                )
            }
        case .dropDown:
            if case let .dropDown(attribute) = field.attribute {
                Picker(
                    selection: Binding<String>(
                        get: { fieldValues[field.code]?.string ?? attribute.defaultValue },
                        set: { fieldValues[field.code] = .dropDown($0) }
                    ),
                    content: {
                        ForEach(attribute.options) { option in
                            Text(option.label).tag(option.label)
                        }
                    },
                    label: { Text(field.label) }
                )
            }
        case .multiSelect:
            if case let .multiSelect(attribute) = field.attribute {
                Checkboxes(
                    axis: .vertical,
                    selection: Binding<Set<String>>(
                        get: { .init(fieldValues[field.code]?.strings ?? attribute.defaultValue) },
                        set: { fieldValues[field.code] = .multiSelect($0.map({ $0 })) }
                    ),
                    content: {
                        ForEach(attribute.options) { option in
                            Text(option.label).tag(option.label)
                        }
                    },
                    label: { Text(field.label) }
                )
            }
        case .userSelect:
            if case let .userSelect(attribute) = field.attribute {
                Checkboxes(
                    axis: .vertical,
                    selection: Binding<Set<String>>(
                        get: { .init(fieldValues[field.code]?.entities?.map(\.code) ?? attribute.defaultValue.map(\.code)) },
                        set: { fieldValues[field.code] = .userSelect($0.map { Entity.Write(type: .user, code: $0) }) }
                    ),
                    content: {
                        ForEach(attribute.entities) { entity in
                            Text(entity.code).tag(entity.code)
                        }
                    },
                    label: { Text(field.code) }
                )
            }
        case .organizationSelect:
            if case let .organizationSelect(attribute) = field.attribute {
                Checkboxes(
                    axis: .vertical,
                    selection: Binding<Set<String>>(
                        get: { .init(fieldValues[field.code]?.entities?.map(\.code) ?? attribute.defaultValue.map(\.code)) },
                        set: { fieldValues[field.code] = .organizationSelect($0.map { Entity.Write(type: .organization, code: $0) }) }
                    ),
                    content: {
                        ForEach(attribute.entities) { entity in
                            Text(entity.code).tag(entity.code)
                        }
                    },
                    label: { Text(field.code) }
                )
            }
        case .groupSelect:
            if case let .groupSelect(attribute) = field.attribute {
                Checkboxes(
                    axis: .vertical,
                    selection: Binding<Set<String>>(
                        get: { .init(fieldValues[field.code]?.entities?.map(\.code) ?? attribute.defaultValue.map(\.code)) },
                        set: { fieldValues[field.code] = .groupSelect($0.map { Entity.Write(type: .group, code: $0) }) }
                    ),
                    content: {
                        ForEach(attribute.entities) { entity in
                            Text(entity.code).tag(entity.code)
                        }
                    },
                    label: { Text(field.code) }
                )
            }
        case .date:
            if case let .date(attribute) = field.attribute {
                DatePicker(
                    selection: Binding<Date>(
                        get: { fieldValues[field.code]?.date ?? attribute.defaultValue },
                        set: { fieldValues[field.code] = .date($0) }
                    ),
                    displayedComponents: .date,
                    label: { Text(field.label) }
                )
            }
        case .dateTime:
            if case let .dateTime(attribute) = field.attribute {
                DatePicker(
                    selection: Binding<Date>(
                        get: { fieldValues[field.code]?.date ?? attribute.defaultValue },
                        set: { fieldValues[field.code] = .dateTime($0) }
                    ),
                    displayedComponents: [.date, .hourAndMinute],
                    label: { Text(field.label) }
                )
            }
        case .time:
            if case let .time(attribute) = field.attribute {
                DatePicker(
                    selection: Binding<Date>(
                        get: { fieldValues[field.code]?.date ?? attribute.defaultValue },
                        set: { fieldValues[field.code] = .time($0) }
                    ),
                    displayedComponents: .hourAndMinute,
                    label: { Text(field.label) }
                )
            }
        default:
            EmptyView()
        }
    }
}
