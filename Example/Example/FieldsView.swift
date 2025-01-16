//
//  FieldsView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FieldsView: View {
    var fields: [FieldProperty]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(fields.indices, id: \.self) { i in
                    let field = fields[i]
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Type: \(field.type)")
                            Text("Code: \(field.code)")
                            Text("Label: \(field.label)")
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 4) {
                            switch field.data {
                            case let .calc(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Expression: \(data.expression)")
                                CornerRadiusText("Hide Expression: \(data.hideExpression)")
                                CornerRadiusText("Format: \(data.format)")
                                CornerRadiusText("Display Scale: \(data.displayScale)")
                                CornerRadiusText("Unit: \(data.unit)")
                                CornerRadiusText("Unit Position: \(data.unitPosition)")

                            case let .category(data):
                                CornerRadiusText("Enabled: \(data.enabled)")

                            case let .checkBox(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                OptionsView(options: data.options)
                                CornerRadiusText("Default Value: \(data.defaultValue.joined(separator: ","))")
                                CornerRadiusText("Alignment: \(data.alignment)")

                            case let .createdTime(data):
                                CornerRadiusText("No Label: \(data.noLabel)")

                            case let .creator(data):
                                CornerRadiusText("No Label: \(data.noLabel)")

                            case let .date(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Unique: \(data.unique)")
                                CornerRadiusText("Default Now Value: \(data.defaultNowValue)")
                                CornerRadiusText("Default Value: \(String(optional: data.defaultValue))")

                            case let .dateTime(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Unique: \(data.unique)")
                                CornerRadiusText("Default Now Value: \(data.defaultNowValue)")
                                CornerRadiusText("Default Value: \(String(optional: data.defaultValue))")

                            case let .dropDown(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                OptionsView(options: data.options)
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")

                            case let .file(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Thumbnail Size: \(data.thumbnailSize)")

                            case let .group(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Open Group: \(data.openGroup)")

                            case let .groupSelect(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                EntitiesView(label: "Entities:", entities: data.entities)
                                EntitiesView(label: "Default Value:", entities: data.defaultValue)

                            case let .link(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Link Protocol: \(data.linkProtocol)")
                                CornerRadiusText("Min Length: \(data.minLength)")
                                CornerRadiusText("Max Length: \(data.maxLength)")
                                CornerRadiusText("Unique: \(data.unique)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")

                            case let .lookup(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("RelatedApp/App: \(data.lookup.relatedApp.app)")
                                CornerRadiusText("RelatedApp/Code: \(data.lookup.relatedApp.code)")
                                CornerRadiusText("RelatedKeyField: \(data.lookup.relatedKeyField)")
                                FieldMappingsView(fieldMappings: data.lookup.fieldMappings)
                                CornerRadiusText("LookupPickerFields: \(data.lookup.lookupPickerFields.joined(separator: ","))")
                                CornerRadiusText("Filter Condition: \(data.lookup.filterCondition)")
                                CornerRadiusText("Sort: \(data.lookup.sort)")

                            case let .modifier(data):
                                CornerRadiusText("No Label: \(data.noLabel)")

                            case let .multiLineText(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")

                            case let .multiSelect(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                OptionsView(options: data.options)
                                CornerRadiusText("Default Value: \(data.defaultValue.joined(separator: ","))")

                            case let .number(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Min Value: \(data.minValue)")
                                CornerRadiusText("Max Value: \(data.maxValue)")
                                CornerRadiusText("Digit: \(data.digit)")
                                CornerRadiusText("Unique: \(data.unique)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")
                                CornerRadiusText("Display Scale: \(data.displayScale)")
                                CornerRadiusText("Unit: \(data.unit)")
                                CornerRadiusText("Unit Position: \(data.unitPosition)")

                            case let .organizationSelect(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                EntitiesView(label: "Entities:", entities: data.entities)
                                EntitiesView(label: "Default Value:", entities: data.defaultValue)

                            case let .radioButton(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                OptionsView(options: data.options)
                                CornerRadiusText("Default Value: \(data.defaultValue)")
                                CornerRadiusText("Alignment: \(data.alignment)")

                            case let .recordNumber(data):
                                CornerRadiusText("No Label: \(data.noLabel)")

                            case let .richText(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")

                            case let .singleLineText(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Min Length: \(data.minLength)")
                                CornerRadiusText("Max Length: \(data.maxLength)")
                                CornerRadiusText("Expression: \(data.expression)")
                                CornerRadiusText("Hide Expression: \(data.hideExpression)")
                                CornerRadiusText("Unique: \(data.unique)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")

                            case let .status(data):
                                CornerRadiusText("Enabled: \(data.enabled)")

                            case let .statusAssignee(data):
                                CornerRadiusText("Enabled: \(data.enabled)")

                            case let .time(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                CornerRadiusText("Default Now Value: \(data.defaultNowValue)")
                                CornerRadiusText("Default Value: \(data.defaultValue)")

                            case let .updatedTime(data):
                                CornerRadiusText("No Label: \(data.noLabel)")

                            case let .userSelect(data):
                                CornerRadiusText("No Label: \(data.noLabel)")
                                CornerRadiusText("Required: \(data.required)")
                                EntitiesView(label: "Entities:", entities: data.entities)
                                EntitiesView(label: "Default Value:", entities: data.defaultValue)

                            case .other:
                                Spacer().frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .cornerRadiusBorder()
                }
            }
            .padding()
        }
    }
}

private struct CornerRadiusText: View {
    var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadiusBorder()
    }
}

private struct OptionsView: View {
    var options: [FieldOption]

    var body: some View {
        HStack(alignment: .top) {
            Text("Options:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(options.indices, id: \.self) { j in
                    let option = options[j]
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Label: \(option.label)")
                        Text("Index: \(option.index)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadiusBorder()
                }
            }
            if options.isEmpty {
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .cornerRadiusBorder()
    }
}

private struct EntitiesView: View {
    var label: String
    var entities: [FieldEntity]

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(entities.indices, id: \.self) { j in
                    let entity = entities[j]
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Code: \(entity.code)")
                        Text("Type: \(entity.type)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadiusBorder()
                }
            }
            if entities.isEmpty {
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .cornerRadiusBorder()
    }
}

private struct FieldMappingsView: View {
    var fieldMappings: [FieldMapping]

    var body: some View {
        HStack(alignment: .top) {
            Text("FieldMappings:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(fieldMappings.indices, id: \.self) { j in
                    let fieldMapping = fieldMappings[j]
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Field: \(fieldMapping.field)")
                        Text("Related Field: \(fieldMapping.relatedField)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadiusBorder()
                }
            }
            if fieldMappings.isEmpty {
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .cornerRadiusBorder()
    }
}
