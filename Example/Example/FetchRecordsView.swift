//
//  FetchRecordsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FetchRecordsView: View {
    var records: [Record.Read]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(records.indices, id: \.self) { i in
                    RecordsDetailView(record: records[i])
                }
            }
            .padding()
        }
    }
}

private struct RecordsDetailView: View {
    var record: Record.Read
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(record.fields) { recordField in
                RecordFieldView(recordField: recordField)
            }
        }
        .cornerRadiusBorder()
    }
}

private struct RecordFieldView: View {
    var recordField: RecordField.Read
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Code: \(recordField.code)")
            switch recordField.value {
            case let .calc(string),
                let .id(string),
                let .link(string),
                let .multiLineText(string),
                let .number(string),
                let .recordNumber(string),
                let .revision(string),
                let .richText(string),
                let .singleLineText(string),
                let .status(string):
                Text("Value: \(string)")
                
            case let .dropDown(string),
                let .radioButton(string):
                Text("Value: \(String(optional: string))")

            case let .category(stringArray),
                let .checkBox(stringArray),
                let .multiSelect(stringArray):
                Text("Value: \(stringArray)")

            case let .createdTime(date),
                let .updatedTime(date):
                Text("Value: \(date)")
                
            case let .date(date),
                let .dateTime(date),
                let .time(date):
                Text("Value: \(String(optional: date))")
                
            case let .creator(entity),
                let .modifier(entity),
                let .statusAssignee(entity):
                HStack(alignment: .top) {
                    Text("Value:")
                    Divider()
                    VStack(alignment: .leading, spacing: 4) {
                        CornerRadiusText("Type: \(entity.type.rawValue)")
                        CornerRadiusText("Code: \(entity.code)")
                        CornerRadiusText("Name: \(String(optional: entity.name))")
                    }
                }
                .cornerRadiusBorder()
                
            case let .file(file):
                Text("Value: \(file)")
                
            case let .groupSelect(entityArray),
                let .organizationSelect(entityArray),
                let .userSelect(entityArray):
                Text("Value: \(entityArray)")
                
            case let .subTable(subtableValueArray):
                ForEach(subtableValueArray.indices, id: \.self) { j in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("ID: \(subtableValueArray[j].id)")
                        ForEach(subtableValueArray[j].value) { recordField in
                            RecordFieldView(recordField: recordField)
                        }
                    }
                    .cornerRadiusBorder()
                }
            }
        }
        .cornerRadiusBorder()
    }
}
