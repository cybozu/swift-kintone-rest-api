//
//  SubmitRecordView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct SubmitRecordView: View {
    private var fields: [Field]
    private var onSubmitRecordHandler: ([String: RecordFieldValue.Write]) async -> SubmitRecordResponse?
    private var onUpdateRecordHandler: (Int, [String: RecordFieldValue.Write]) async -> UpdateRecordResponse?
    private var onRemoveRecordHandler: (Int) async -> Void
    @State private var recordID: Int?
    @State private var revision: Int?
    @State private var fieldValues: [String: RecordFieldValue.Write] = [:]

    init(
        fieldsResponse: FetchFieldsResponse?,
        onSubmitRecordHandler: @escaping ([String: RecordFieldValue.Write]) async -> SubmitRecordResponse?,
        onUpdateRecordHandler: @escaping (Int, [String: RecordFieldValue.Write]) async -> UpdateRecordResponse?,
        onRemoveRecordHandler: @escaping (Int) async -> Void
    ) {
        fields = fieldsResponse?.fields ?? []
        self.onSubmitRecordHandler = onSubmitRecordHandler
        self.onUpdateRecordHandler = onUpdateRecordHandler
        self.onRemoveRecordHandler = onRemoveRecordHandler
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
                    HStack {
                        Button {
                            Task {
                                if let response = await onSubmitRecordHandler(fieldValues) {
                                    recordID = response.recordIdentity.id
                                    revision = response.recordIdentity.revision
                                }
                            }
                        } label: {
                            Text("Submit")
                        }
                        Button {
                            Task {
                                guard let recordID else { return }
                                revision = await onUpdateRecordHandler(recordID, fieldValues)?.revision
                            }
                        } label: {
                            Text("Update")
                        }
                        .disabled(recordID == nil)
                        Button {
                            Task {
                                guard let recordID else { return }
                                await onRemoveRecordHandler(recordID)
                                self.recordID = nil
                                self.revision = nil
                            }
                        } label: {
                            Text("Remove")
                        }
                        .disabled(recordID == nil)
                    }
                    .buttonStyle(.borderedProminent)
                } label: {
                    EmptyView()
                }
            } header: {
                Text("Record ID: \(String(optional: recordID)), Revision: \(String(optional: revision))")
            }
        }
        .onAppear {
            fieldValues = fields.reduce(into: [String: RecordFieldValue.Write]()) {
                $0[$1.code] = switch $1.attribute {
                case let .checkBox(value):
                    RecordFieldValue.Write.checkBox(value.defaultValue)
                case let .date(value):
                    RecordFieldValue.Write.date(value.defaultValue)
                case let .dateTime(value):
                    RecordFieldValue.Write.dateTime(value.defaultValue)
                case let .dropDown(value):
                    RecordFieldValue.Write.dropDown(value.defaultValue)
                case let .groupSelection(value):
                    RecordFieldValue.Write.groupSelection(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
                case let .link(value):
                    RecordFieldValue.Write.link(value.defaultValue)
                case let .multiLineText(value):
                    RecordFieldValue.Write.multiLineText(value.defaultValue)
                case let .multiSelection(value):
                    RecordFieldValue.Write.multiSelection(value.defaultValue)
                case let .number(value):
                    RecordFieldValue.Write.number(value.defaultValue)
                case let .organizationSelection(value):
                    RecordFieldValue.Write.organizationSelection(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
                case let .radioButton(value):
                    RecordFieldValue.Write.radioButton(value.defaultValue)
                case let .richText(value):
                    RecordFieldValue.Write.richText(value.defaultValue)
                case let .singleLineText(value):
                    RecordFieldValue.Write.singleLineText(value.defaultValue)
                case let .time(value):
                    RecordFieldValue.Write.time(value.defaultValue)
                case let .userSelection(value):
                    RecordFieldValue.Write.userSelection(value.defaultValue.map({ Entity.Write(type: $0.type, code: $0.code) }))
                default:
                    nil
                }
            }
        }
    }
}
