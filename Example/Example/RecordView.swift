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
    var onSubmitHandler: ([RecordField]) -> Void
    @State private var fieldValues: [String: RecordFieldValue]

    init(fields: [FieldProperty], onSubmitHandler: @escaping ([RecordField]) -> Void) {
        self.fields = fields
        self.onSubmitHandler = onSubmitHandler
        self.fieldValues = fields.reduce(into: [String: RecordFieldValue]()) {
            $0[$1.code] = .defaultValue(fieldProperty: $1)
        }
    }

    var body: some View {
        Form {
            Section {
                ForEach(fields) { field in
                    switch field.type {
                    case .richText:
                        if case let .richText(data) = field.data {
                            LabeledContent {
                                TextField(
                                    text: Binding<String>(
                                        get: { fieldValues[field.code]?.string ?? data.defaultValue },
                                        set: { fieldValues[field.code] = .richText($0) }
                                    ),
                                    label: { Text(data.defaultValue) }
                                )
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text(field.label)
                            }
                        }
                    case .multiLineText:
                        if case let .multiLineText(data) = field.data {
                            LabeledContent {
                                TextField(
                                    text: Binding<String>(
                                        get: { fieldValues[field.code]?.string ?? data.defaultValue },
                                        set: { fieldValues[field.code] = .multiLineText($0) }
                                    ),
                                    label: { Text(data.defaultValue) }
                                )
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text(field.label)
                            }
                        }
                    case .singleLineText:
                        if case let .singleLineText(data) = field.data {
                            LabeledContent {
                                TextField(
                                    text: Binding<String>(
                                        get: { fieldValues[field.code]?.string ?? data.defaultValue },
                                        set: { fieldValues[field.code] = .singleLineText($0) }
                                    ),
                                    label: { Text(data.defaultValue) }
                                )
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text(field.label)
                            }
                        }
                    case .number:
                        if case let .number(data) = field.data {
                            LabeledContent {
                                TextField(
                                    text: Binding<String>(
                                        get: { fieldValues[field.code]?.string ?? data.defaultValue },
                                        set: { fieldValues[field.code] = .number($0.description) }
                                    ),
                                    label: { Text(data.defaultValue) }
                                )
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text(field.label)
                            }
                        }
                    case .link:
                        if case let .link(data) = field.data {
                            LabeledContent {
                                TextField(
                                    text: Binding<String>(
                                        get: { fieldValues[field.code]?.string ?? data.defaultValue },
                                        set: { fieldValues[field.code] = .link($0) }
                                    ),
                                    label: { Text(data.defaultValue) }
                                )
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text(field.label)
                            }
                        }
                    case .radioButton:
                        if case let .radioButton(data) = field.data {
                            Picker(
                                selection: Binding<String>(
                                    get: { fieldValues[field.code]?.string ?? data.defaultValue },
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
                    case .checkBox:
                        if case let .checkBox(data) = field.data {
                            Checkboxes(
                                axis: .vertical,
                                selection: Binding<Set<String>>(
                                    get: { .init(fieldValues[field.code]?.strings ?? data.defaultValue) },
                                    set: { fieldValues[field.code] = .checkBox($0.map({ $0 })) }
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
                                    get: { fieldValues[field.code]?.string ?? data.defaultValue },
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
                    case .multiSelect:
                        if case let .multiSelect(data) = field.data {
                            Checkboxes(
                                axis: .vertical,
                                selection: Binding<Set<String>>(
                                    get: { .init(fieldValues[field.code]?.strings ?? data.defaultValue) },
                                    set: { fieldValues[field.code] = .multiSelect($0.map({ $0 })) }
                                ),
                                content: {
                                    ForEach(data.options, id: \.index) { option in
                                        Text(option.label).tag(option.label)
                                    }
                                },
                                label: { Text(field.label) }
                            )
                        }
                    case .userSelect:
                        if case let .userSelect(data) = field.data {
                            Checkboxes(
                                axis: .vertical,
                                selection: Binding<Set<String>>(
                                    get: { .init(fieldValues[field.code]?.codeObjects?.map(\.code) ?? data.defaultValue.map(\.code)) },
                                    set: { fieldValues[field.code] = .userSelect($0.map({ .init(code: $0) })) }
                                ),
                                content: {
                                    ForEach(data.entities, id: \.code) { entity in
                                        Text(entity.code).tag(entity.code)
                                    }
                                },
                                label: { Text(field.code) }
                            )
                        }
                    case .organizationSelect:
                        if case let .organizationSelect(data) = field.data {
                            Checkboxes(
                                axis: .vertical,
                                selection: Binding<Set<String>>(
                                    get: { .init(fieldValues[field.code]?.codeObjects?.map(\.code) ?? data.defaultValue.map(\.code)) },
                                    set: { fieldValues[field.code] = .organizationSelect($0.map { .init(code: $0) }) }
                                ),
                                content: {
                                    ForEach(data.entities, id: \.code) { entity in
                                        Text(entity.code).tag(entity.code)
                                    }
                                },
                                label: { Text(field.code) }
                            )
                        }
                    case .groupSelect:
                        if case let .groupSelect(data) = field.data {
                            Checkboxes(
                                axis: .vertical,
                                selection: Binding<Set<String>>(
                                    get: { .init(fieldValues[field.code]?.codeObjects?.map(\.code) ?? data.defaultValue.map(\.code)) },
                                    set: { fieldValues[field.code] = .groupSelect($0.map { .init(code: $0) }) }
                                ),
                                content: {
                                    ForEach(data.entities, id: \.code) { entity in
                                        Text(entity.code).tag(entity.code)
                                    }
                                },
                                label: { Text(field.code) }
                            )
                        }
                    case .date:
                        if case let .date(data) = field.data {
                            DatePicker(
                                selection: Binding<Date>(
                                    get: { fieldValues[field.code]?.date ?? data.defaultValue },
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
                                    get: { fieldValues[field.code]?.date ?? data.defaultValue },
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
                                    get: { fieldValues[field.code]?.date ?? data.defaultValue },
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
                        let array = fieldValues.map { (key, value) in
                            RecordField(code: key, value: value)
                        }
                        onSubmitHandler(array)
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
extension FieldProperty: @retroactive Identifiable {
    public var id: String { code }
}
