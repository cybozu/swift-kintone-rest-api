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
                        set: { fieldValues[field.code] = .number($0.description) }
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
        case (.checkBox, let .checkBox(attribute), let .checkBox(value)):
            Checkboxes(
                axis: .vertical,
                selection: Binding<Set<String>>(
                    get: { .init(value) },
                    set: { fieldValues[field.code] = .checkBox($0.map(\.self)) }
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
            Checkboxes(
                axis: .vertical,
                selection: Binding<Set<String>>(
                    get: { .init(value.map(\.code)) },
                    set: { fieldValues[field.code] = .userSelection($0.map { Entity.Write(type: .user, code: $0) }) }
                ),
                content: {
                    ForEach(attribute.entities) { entity in
                        Text(entity.code).tag(entity.code)
                    }
                },
                label: { Text(field.code) }
            )
        case (.organizationSelection, let .organizationSelection(attribute), let .organizationSelection(value)):
            Checkboxes(
                axis: .vertical,
                selection: Binding<Set<String>>(
                    get: { .init(value.map(\.code)) },
                    set: { fieldValues[field.code] = .organizationSelection($0.map { Entity.Write(type: .organization, code: $0) }) }
                ),
                content: {
                    ForEach(attribute.entities) { entity in
                        Text(entity.code).tag(entity.code)
                    }
                },
                label: { Text(field.code) }
            )
        case (.groupSelection, let .groupSelection(attribute), let .groupSelection(value)):
            Checkboxes(
                axis: .vertical,
                selection: Binding<Set<String>>(
                    get: { .init(value.map(\.code)) },
                    set: { fieldValues[field.code] = .groupSelection($0.map { Entity.Write(type: .group, code: $0) }) }
                ),
                content: {
                    ForEach(attribute.entities) { entity in
                        Text(entity.code).tag(entity.code)
                    }
                },
                label: { Text(field.code) }
            )
        case (.date, .date, let .date(value)):
            DatePicker(
                selection: Binding<Date>(
                    get: { value },
                    set: { fieldValues[field.code] = .date($0) }
                ),
                displayedComponents: .date,
                label: { Text(field.label) }
            )
        case (.dateTime, .dateTime, let .dateTime(value)):
            DatePicker(
                selection: Binding<Date>(
                    get: { value },
                    set: { fieldValues[field.code] = .dateTime($0) }
                ),
                displayedComponents: [.date, .hourAndMinute],
                label: { Text(field.label) }
            )
        case (.time, .time, let .time(value)):
            DatePicker(
                selection: Binding<Date>(
                    get: { value },
                    set: { fieldValues[field.code] = .time($0) }
                ),
                displayedComponents: .hourAndMinute,
                label: { Text(field.label) }
            )
        default:
            EmptyView()
        }
    }
}
