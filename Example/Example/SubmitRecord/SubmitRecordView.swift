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
    var onSubmitRecordHandler: ([String: RecordFieldValue.Write]) async -> RecordIdentity.Read?
    var onUpdateRecordHandler: (Int, [String: RecordFieldValue.Write]) async -> RecordIdentity.Read?
    var onDeleteRecordHandler: (Int) async -> Void
    @State private var recordID: Int?
    @State private var revision: Int?
    @State private var fieldValues: [String: RecordFieldValue.Write]

    init(
        fields: [FieldProperty],
        onSubmitRecordHandler: @escaping ([String: RecordFieldValue.Write]) async -> RecordIdentity.Read?,
        onUpdateRecordHandler: @escaping (Int, [String: RecordFieldValue.Write]) async -> RecordIdentity.Read?,
        onDeleteRecordHandler: @escaping (Int) async -> Void
    ) {
        self.fields = fields
        self.onSubmitRecordHandler = onSubmitRecordHandler
        self.onUpdateRecordHandler = onUpdateRecordHandler
        self.onDeleteRecordHandler = onDeleteRecordHandler
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
                    RecordInputFieldView(field: field, fieldValues: $fieldValues)
                }
            }
            Section {
                LabeledContent {
                    Button {
                        Task {
                            if let recordIdentity = await onSubmitRecordHandler(fieldValues) {
                                self.recordID = recordIdentity.id
                                self.revision = recordIdentity.revision
                            }
                        }
                    } label: {
                        Text("Submit")
                    }
                    .buttonStyle(.borderedProminent)
                } label: {
                    EmptyView()
                }
                LabeledContent {
                    HStack {
                        Button {
                            Task {
                                guard let recordID else { return }
                                if let recordIdentity = await onUpdateRecordHandler(recordID, fieldValues) {
                                    self.revision = recordIdentity.revision
                                }
                            }
                        } label: {
                            Text("Update")
                        }
                        Button {
                            Task {
                                guard let recordID else { return }
                                await onDeleteRecordHandler(recordID)
                                self.recordID = nil
                                self.revision = nil
                            }
                        } label: {
                            Text("Delete")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(recordID == nil)
                } label: {
                    Text("Record ID: \(String(optional: recordID)), Revision: \(String(optional: revision))")
                }
            }
        }
    }
}
