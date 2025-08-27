//
//  FieldDetailView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FieldDetailView: View {
    var field: Field

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Type: \(field.type.rawValue)")
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
                    CornerRadiusText("Display Scale: \(String(optional: attribute.displayScale))")
                    CornerRadiusText("Unit: \(attribute.unit)")
                    CornerRadiusText("Unit Position: \(attribute.unitPosition)")

                case let .category(attribute):
                    CornerRadiusText("Enabled: \(attribute.enabled)")

                case let .checkbox(attribute):
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

                case let .groupSelection(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    EntitiesView(label: "Entities:", entities: attribute.entities)
                    EntitiesView(label: "Default Value:", entities: attribute.defaultValue)

                case let .link(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Link Protocol: \(attribute.linkProtocol)")
                    CornerRadiusText("Min Length: \(String(optional: attribute.minLength))")
                    CornerRadiusText("Max Length: \(String(optional: attribute.maxLength))")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .lookup(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Related App/App: \(attribute.lookup.relatedApp.appID)")
                    CornerRadiusText("Related App/Code: \(attribute.lookup.relatedApp.code)")
                    CornerRadiusText("Related Key Field: \(attribute.lookup.relatedKeyField)")
                    FieldMappingsView(fieldMappings: attribute.lookup.fieldMappings)
                    CornerRadiusText("Lookup Picker Fields: \(attribute.lookup.lookupPickerFields.joined(separator: ","))")
                    CornerRadiusText("Filter Condition: \(attribute.lookup.filterCondition)")
                    CornerRadiusText("Sort: \(attribute.lookup.sort)")

                case let .modifier(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .multiLineText(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .multiSelection(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    OptionsView(options: attribute.options)
                    CornerRadiusText("Default Value: \(attribute.defaultValue.joined(separator: ","))")

                case let .number(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Min Value: \(String(optional: attribute.minValue))")
                    CornerRadiusText("Max Value: \(String(optional: attribute.maxValue))")
                    CornerRadiusText("Digit: \(attribute.digit)")
                    CornerRadiusText("Unique: \(attribute.unique)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")
                    CornerRadiusText("Display Scale: \(String(optional: attribute.displayScale))")
                    CornerRadiusText("Unit: \(attribute.unit)")
                    CornerRadiusText("Unit Position: \(attribute.unitPosition)")

                case let .organizationSelection(attribute):
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

                case let .referenceTable(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Related App/App: \(attribute.referenceTable.relatedApp.appID)")
                    CornerRadiusText("Related App/Code: \(attribute.referenceTable.relatedApp.code)")
                    CornerRadiusText("Condition/Field: \(attribute.referenceTable.condition.field)")
                    CornerRadiusText("Condition/Related Field: \(attribute.referenceTable.condition.relatedField)")
                    CornerRadiusText("Filter Condition: \(attribute.referenceTable.filterCondition)")
                    CornerRadiusText("Display Fields: \(attribute.referenceTable.displayFields.joined(separator: ","))")
                    CornerRadiusText("Sort: \(attribute.referenceTable.sort)")
                    CornerRadiusText("Size: \(attribute.referenceTable.size)")

                case let .richText(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .singleLineText(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Min Length: \(String(optional: attribute.minLength))")
                    CornerRadiusText("Max Length: \(String(optional: attribute.maxLength))")
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
                            FieldDetailView(field: field)
                        }
                    }

                case let .time(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")
                    CornerRadiusText("Required: \(attribute.required)")
                    CornerRadiusText("Default Now Value: \(attribute.defaultNowValue)")
                    CornerRadiusText("Default Value: \(attribute.defaultValue)")

                case let .updatedTime(attribute):
                    CornerRadiusText("No Label: \(attribute.noLabel)")

                case let .userSelection(attribute):
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
