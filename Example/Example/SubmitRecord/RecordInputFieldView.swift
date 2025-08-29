//
//  RecordInputFieldView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct RecordInputFieldView: View {
    var field: Field
    @Binding var fieldValues: [String: RecordFieldValue.Write]

    var body: some View {
        switch (field.type, field.attribute, fieldValues[field.code]) {
        case (.richText, let .richText(attribute),  let .richText(value)):
            LabeledContent {
                TextField(
                    text: Binding<String>(
                        get: { value },
                        set: { fieldValues[field.code] = .richText($0) }
                    ),
                    label: { Text(attribute.defaultValue) }
                )
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
            } label: {
                Text(field.label)
            }
        case (.multiLineText, let .multiLineText(attribute), let .multiLineText(value)):
            LabeledContent {
                TextField(
                    text: Binding<String>(
                        get: { value },
                        set: { fieldValues[field.code] = .multiLineText($0) }
                    ),
                    label: { Text(attribute.defaultValue) }
                )
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
            } label: {
                Text(field.label)
            }
        case (.singleLineText, let .singleLineText(attribute), let .singleLineText(value)):
            LabeledContent {
                TextField(
                    text: Binding<String>(
                        get: { value },
                        set: { fieldValues[field.code] = .singleLineText($0) }
                    ),
                    label: { Text(attribute.defaultValue) }
                )
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
            } label: {
                Text(field.label)
            }
        case (.number, let .number(attribute), let .number(value)):
            LabeledContent {
                TextField(
                    text: Binding<String>(
                        get: { value },
                        set: { fieldValues[field.code] = .number(String(describing: $0)) }
                    ),
                    label: { Text(attribute.defaultValue) }
                )
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
            } label: {
                Text(field.label)
            }
        case (.link, let .link(attribute), let .link(value)):
            LabeledContent {
                TextField(
                    text: Binding<String>(
                        get: { value },
                        set: { fieldValues[field.code] = .link($0) }
                    ),
                    label: { Text(attribute.defaultValue) }
                )
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
            } label: {
                Text(field.label)
            }
        case (.radioButton, let .radioButton(attribute), let .radioButton(value)):
            Picker(
                selection: Binding<String>(
                    get: { value },
                    set: { fieldValues[field.code] = .radioButton($0) }
                ),
                content: {
                    ForEach(attribute.options) { option in
                        Text(option.label).tag(option.label)
                    }
                },
                label: { Text(field.label) }
            )
        case (.checkbox, let .checkbox(attribute), let .checkbox(value)):
            Checkboxes(
                axis: .vertical,
                selection: Binding<Set<String>>(
                    get: { .init(value) },
                    set: { fieldValues[field.code] = .checkbox($0.map(\.self)) }
                ),
                content: {
                    ForEach(attribute.options) { option in
                        Text(option.label).tag(option.label)
                    }
                },
                label: { Text(field.label) }
            )
        case (.dropDown, let .dropDown(attribute), let .dropDown(value)):
            Picker(
                selection: Binding<String?>(
                    get: { value },
                    set: { fieldValues[field.code] = .dropDown($0) }
                ),
                content: {
                    Text("-").tag(String?.none)
                    ForEach(attribute.options) { option in
                        Text(option.label).tag(option.label)
                    }
                },
                label: { Text(field.label) }
            )
        case (.multiSelection, let .multiSelection(attribute), let .multiSelection(value)):
            Checkboxes(
                axis: .vertical,
                selection: Binding<Set<String>>(
                    get: { .init(value) },
                    set: { fieldValues[field.code] = .multiSelection($0.map(\.self)) }
                ),
                content: {
                    ForEach(attribute.options) { option in
                        Text(option.label).tag(option.label)
                    }
                },
                label: { Text(field.label) }
            )
        case (.userSelection, let .userSelection(attribute), let .userSelection(value)):
            SelectionView(
                label: field.code,
                entities: attribute.entities,
                value: value,
                selection: Binding<Set<String>>(
                    get: { .init(value.map(\.code)) },
                    set: { fieldValues[field.code] = .userSelection($0.map { Entity.Write(type: .user, code: $0) }) }
                )
            )
        case (.organizationSelection, let .organizationSelection(attribute), let .organizationSelection(value)):
            SelectionView(
                label: field.code,
                entities: attribute.entities,
                value: value,
                selection: Binding<Set<String>>(
                    get: { .init(value.map(\.code)) },
                    set: { fieldValues[field.code] = .organizationSelection($0.map { Entity.Write(type: .organization, code: $0) }) }
                )
            )
        case (.groupSelection, let .groupSelection(attribute), let .groupSelection(value)):
            SelectionView(
                label: field.code,
                entities: attribute.entities,
                value: value,
                selection: Binding<Set<String>>(
                    get: { .init(value.map(\.code)) },
                    set: { fieldValues[field.code] = .groupSelection($0.map { Entity.Write(type: .group, code: $0) }) }
                )
            )
        case (.date, .date, let .date(value)):
            DatePicker(
                selection: Binding<Date>(
                    get: { value ?? Date.now },
                    set: { fieldValues[field.code] = .date($0) }
                ),
                displayedComponents: .date,
                label: { Text(field.label) }
            )
        case (.dateTime, .dateTime, let .dateTime(value)):
            DatePicker(
                selection: Binding<Date>(
                    get: { value ?? Date.now },
                    set: { fieldValues[field.code] = .dateTime($0) }
                ),
                displayedComponents: [.date, .hourAndMinute],
                label: { Text(field.label) }
            )
        case (.time, .time, let .time(value)):
            DatePicker(
                selection: Binding<Date>(
                    get: { value ?? Date.now },
                    set: { fieldValues[field.code] = .time($0) }
                ),
                displayedComponents: .hourAndMinute,
                label: { Text(field.label) }
            )
        case (.subtable, let .subtable(attribute), let .subtable(value)):
            SubtableView(
                fields: attribute.fields,
                values: Binding<[[RecordField.Write]]>(
                    get: { value },
                    set: { fieldValues[field.code] = .subtable($0) }
                )
            )
        default:
            EmptyView()
        }
    }
}

private struct SelectionView: View {
    var label: String
    var entities: [Entity.Read]
    var value: [Entity.Write]
    @Binding var selection: Set<String>

    var body: some View {
        if entities.isEmpty {
            LabeledContent {
                Text(value.map(\.code).joined(separator: ","))
            } label: {
                Text(label)
            }
        } else {
            Checkboxes(
                axis: .vertical,
                selection: $selection,
                content: {
                    ForEach(entities) { entity in
                        Text(entity.code).tag(entity.code)
                    }
                },
                label: { Text(label) }
            )
        }
    }
}
