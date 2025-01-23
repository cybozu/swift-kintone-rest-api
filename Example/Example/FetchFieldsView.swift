//
//  FetchFieldsView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchFieldsView: View {
    var fields: [FieldProperty]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(fields) { field in
                    FieldsDetailView(field: field)
                }
            }
            .padding()
        }
    }
}

private struct FieldsDetailView: View {
    var field: FieldProperty
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Type: \(field.type)")
                Text("Code: \(field.code)")
                Text("Label: \(field.label)")
            }
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                switch field.attribute {
                case let .calc(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Expression: \(attribute.expression)")
                    CornerRadiusText("Hide Expression: \(attribute.hideExpression)")
                    CornerRadiusText("Format: \(attribute.format)")
                    CornerRadiusText("Display Scale: \(attribute.displayScale)")
                    CornerRadiusText("Unit: \(attribute.unit)")
                    CornerRadiusText("Unit Position: \(attribute.unitPosition)")

                case let .category(attribute):
                    CornerRadiusText("Enabled: \(attribute.enabled)")

                case let .checkBox(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    OptionsView(options: attribute.options)
                    CornerRadiusText("Default Value: \(attribute.defaultValue.joined(separator: ","))")
                    CornerRadiusText("Alignment: \(attribute.alignment)")

                case let .createdTime(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .creator(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .date(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Now Value: \(attribute.defaultNowValue)")
                    CornerRadiusText("Default Value: \(String(optional: attribute.defaultValue))")

                case let .dateTime(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Now Value: \(attribute.defaultNowValue)")
                    CornerRadiusText("Default Value: \(String(optional: attribute.defaultValue))")

                case let .dropDown(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    OptionsView(options: attribute.options)
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .file(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Thumbnail Size: \(attribute.thumbnailSize)")

                case let .group(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Open Group: \(attribute.openGroup)")

                case let .groupSelect(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    EntitiesView(label: "Entities:", entities: attribute.entities)
                    EntitiesView(label: "Default Value:", entities: attribute.defaultValue)

                case let .link(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Link Protocol: \(attribute.linkProtocol)")
                    CornerRadiusText("Min Length: \(attribute.minLength)")
                    CornerRadiusText("Max Length: \(attribute.maxLength)")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .lookup(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("RelatedApp/App: \(attribute.lookup.relatedApp.app)")
                    CornerRadiusText("RelatedApp/Code: \(attribute.lookup.relatedApp.code)")
                    CornerRadiusText("RelatedKeyField: \(attribute.lookup.relatedKeyField)")
                    FieldMappingsView(fieldMappings: attribute.lookup.fieldMappings)
                    CornerRadiusText("LookupPickerFields: \(attribute.lookup.lookupPickerFields.joined(separator: ","))")
                    CornerRadiusText("Filter Condition: \(attribute.lookup.filterCondition)")
                    CornerRadiusText("Sort: \(attribute.lookup.sort)")

                case let .modifier(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .multiLineText(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .multiSelect(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    OptionsView(options: attribute.options)
                    CornerRadiusText("Default Value: \(attribute.defaultValue.joined(separator: ","))")

                case let .number(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Min Value: \(attribute.minValue)")
                    CornerRadiusText("Max Value: \(attribute.maxValue)")
                    CornerRadiusText("Digit: \(attribute.digit)")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")
                    CornerRadiusText("Display Scale: \(attribute.displayScale)")
                    CornerRadiusText("Unit: \(attribute.unit)")
                    CornerRadiusText("Unit Position: \(attribute.unitPosition)")

                case let .organizationSelect(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    EntitiesView(label: "Entities:", entities: attribute.entities)
                    EntitiesView(label: "Default Value:", entities: attribute.defaultValue)

                case let .radioButton(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    OptionsView(options: attribute.options)
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")
                    CornerRadiusText("Alignment: \(attribute.alignment)")

                case let .recordNumber(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .richText(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .singleLineText(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Min Length: \(attribute.minLength)")
                    CornerRadiusText("Max Length: \(attribute.maxLength)")
                    CornerRadiusText("Expression: \(attribute.expression)")
                    CornerRadiusText("Hide Expression: \(attribute.hideExpression)")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .status(attribute):
                    CornerRadiusText("Enabled: \(attribute.enabled)")

                case let .statusAssignee(attribute):
                    CornerRadiusText("Enabled: \(attribute.enabled)")

                case let .subtable(attribute):
                    VStack(alignment: .leading, spacing: 4) {
                        CornerRadiusText("No Label: \(attribute.noLabel)")
                        ForEach(attribute.fields) { field in
                            FieldsDetailView(field: field)
                        }
                    }
                    
                case let .time(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Now Value: \(attribute.defaultNowValue)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .updatedTime(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .userSelect(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    EntitiesView(label: "Entities:", entities: attribute.entities)
                    EntitiesView(label: "Default Value:", entities: attribute.defaultValue)
                }
            }
        }
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
                ForEach(options) { option in
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
    var entities: [Entity.Read]

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(entities) { entity in
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
