//
//  RecordFieldView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct RecordFieldView: View {
    var recordField: RecordField.Read
    var actions: [StatusAction]
    var updateStatusHandler: (StatusAction) async -> Void
    var downloadFileHandler: (String) async -> Data?

    var body: some View {
        HStack(alignment: .top) {
            Text("Code: \(recordField.code)")
            Divider()
            switch recordField.value {
            case let .id(integer),
                let .revision(integer):
                CornerRadiusText("Value: \(integer)")

            case let .calc(string),
                let .link(string),
                let .multiLineText(string),
                let .number(string),
                let .recordNumber(string),
                let .richText(string),
                let .singleLineText(string):
                CornerRadiusText("Value: \(string)")

            case let .status(string):
                RecordStatusView(
                    state: string,
                    actions: actions,
                    updateStatusHandler: updateStatusHandler
                )

            case let .dropDown(string),
                let .radioButton(string):
                CornerRadiusText("Value: \(String(optional: string))")

            case let .category(stringArray),
                let .checkBox(stringArray),
                let .multiSelect(stringArray):
                ArrayValueView(stringArray.indices, id: \.self) { i in
                    CornerRadiusText(stringArray[i])
                }

            case let .createdTime(date),
                let .updatedTime(date):
                CornerRadiusText("Value: \(date)")

            case let .date(date),
                let .dateTime(date),
                let .time(date):
                CornerRadiusText("Value: \(String(optional: date))")

            case let .creator(entity),
                let .modifier(entity):
                EntityView(entity: entity)

            case let .file(files):
                ArrayValueView(files) { file in
                    FileView(file: file, downloadFileHandler: downloadFileHandler)
                }

            case let .groupSelect(entityArray),
                let .organizationSelect(entityArray),
                let .statusAssignee(entityArray),
                let .userSelect(entityArray):
                ArrayValueView(entityArray) { entity in
                    EntityView(entity: entity)
                }

            case let .subTable(subtableValueArray):
                ArrayValueView(subtableValueArray.indices, id: \.self) { i in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("ID: \(subtableValueArray[i].id)")
                        ForEach(subtableValueArray[i].value) { recordField in
                            RecordFieldView(
                                recordField: recordField,
                                actions: actions,
                                updateStatusHandler: updateStatusHandler,
                                downloadFileHandler: downloadFileHandler
                            )
                        }
                    }
                    .cornerRadiusBorder()
                }
            }
        }
        .cornerRadiusBorder()
    }
}
