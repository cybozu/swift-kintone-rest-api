//
//  RecordView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct RecordView: View {
    var fields: [FieldProperty]
    var onSubmitHandler: () -> Void
    @State private var fieldValues: [String: RecordFieldValue]

    init(fields: [FieldProperty], onSubmitHandler: @escaping () -> Void) {
        self.fields = fields
        self.onSubmitHandler = onSubmitHandler
        self.fieldValues = fields.reduce(into: [String: RecordFieldValue]()) {
            switch $1.data {
            case let .checkBox(value):
                $0[$1.code] = .checkBox(value.defaultValue)
            case let .date(value):
                $0[$1.code] = .date(value.defaultValue)
            case let .dateTime(value):
                $0[$1.code] = .dateTime(value.defaultValue)
            case let .dropDown(value):
                $0[$1.code] = .dropDown(value.defaultValue)
            case let .groupSelect(value):
                $0[$1.code] = .groupSelect(value.defaultValue.map({ CodeObject(code: $0.code) }))
            case let .link(value):
                $0[$1.code] = .link(value.defaultValue)
            case let .multiLineText(value):
                $0[$1.code] = .multiLineText(value.defaultValue)
            case let .multiSelect(value):
                $0[$1.code] = .multiSelect(value.defaultValue)
            case let .number(value):
                $0[$1.code] = .number(value.defaultValue)
            case let .organizationSelect(value):
                $0[$1.code] = .organizationSelect(value.defaultValue.map({ CodeObject(code: $0.code) }))
            case let .radioButton(value):
                $0[$1.code] = .radioButton(value.defaultValue)
            case let .richText(value):
                $0[$1.code] = .richText(value.defaultValue)
            case let .singleLineText(value):
                $0[$1.code] = .singleLineText(value.defaultValue)
            case let .time(value):
                $0[$1.code] = .time(value.defaultValue)
            case let .userSelect(value):
                $0[$1.code] = .userSelect(value.defaultValue.map({ CodeObject(code: $0.code) }))
            default: 
                break
            }
        }
    }

    var body: some View {
        Form {
            Section {
                ForEach(fields) { field in
                    switch field.type {
                    case .richText:
                        if case let .richText(data) = field.data {
                            TextField(
                                text: Binding<String>(
                                    get: { if case let .richText(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .richText($0) }
                                ),
                                label: { Text(field.label) }
                            )
                        }
                    case .multiLineText:
                        if case let .multiLineText(data) = field.data {
                            TextField(
                                text: Binding<String>(
                                    get: { if case let .multiLineText(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .multiLineText($0) }
                                ),
                                label: { Text(field.label) }
                            )
                        }
                    case .singleLineText:
                        if case let .singleLineText(data) = field.data {
                            TextField(
                                text: Binding<String>(
                                    get: { if case let .singleLineText(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .singleLineText($0) }
                                ),
                                label: { Text(field.label) }
                            )
                        }
                    case .number:
                        if case let .number(data) = field.data {
                            TextField(
                                text: Binding<String>(
                                    get: { if case let .number(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .number($0.description) }
                                ),
                                label: { Text(field.label) }
                            )
                        }
                    case .link:
                        if case let .link(data) = field.data {
                            TextField(
                                text: Binding<String>(
                                    get: { if case let .link(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .link($0) }
                                ),
                                label: { Text(field.label) }
                            )
                        }
                    case .radioButton:
                        if case let .radioButton(data) = field.data {
                            Picker(
                                selection: Binding<String>(
                                    get: { if case let .radioButton(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .radioButton($0) }
                                ),
                                content: {
                                    ForEach(data.options, id: \.index) { option in
                                        Text(option.label).tag(option.label)
                                    }
                                },
                                label: { Text(field.label) }
                            )
                        }
                    case .dropDown:
                        if case let .dropDown(data) = field.data {
                            Picker(
                                selection: Binding<String>(
                                    get: { if case let .dropDown(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .dropDown($0) }
                                ),
                                content: {
                                    ForEach(data.options, id: \.index) { option in
                                        Text(option.label).tag(option.label)
                                    }
                                },
                                label: { Text(field.label) }
                            )
                        }
                    case .date:
                        if case let .date(data) = field.data {
                            DatePicker(
                                selection: Binding<Date>(
                                    get: { if case let .date(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .date($0) }
                                ),
                                displayedComponents: .date,
                                label: { Text(field.label) }
                            )
                        }
                    case .dateTime:
                        if case let .dateTime(data) = field.data {
                            DatePicker(
                                selection: Binding<Date>(
                                    get: { if case let .dateTime(value) = fieldValues[field.code] { value } else { data.defaultValue } },
                                    set: { fieldValues[field.code] = .dateTime($0) }
                                ),
                                displayedComponents: [.date, .hourAndMinute],
                                label: { Text(field.label) }
                            )
                        }
                    case .time:
                        if case let .time(data) = field.data {
                            DatePicker(
                                selection: Binding<Date>(
                                    get: { if case let .time(value) = fieldValues[field.code] { value } else { data.defaultValue } },
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
            Section {
                LabeledContent {
                    Button {
                        onSubmitHandler()
                    } label: {
                        Text("Submit")
                    }
                    .buttonStyle(.borderedProminent)
                } label: {
                    Image(systemName: "paperplane")
                }
            }
        }
    }
}
extension FieldProperty: Identifiable {
    public var id: String { code }
}
