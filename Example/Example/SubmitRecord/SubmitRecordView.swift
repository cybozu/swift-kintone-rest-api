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
    private var onUpdateRecordHandler: (Int, Int, [String: RecordFieldValue.Write]) async -> UpdateRecordResponse?
    private var onRemoveRecordHandler: (Int) async -> Void
    @State private var recordID: Int?
    @State private var revision: Int?
    @State private var fieldValues: [String: RecordFieldValue.Write] = [:]

    init(
        fieldsResponse: FetchFieldsResponse?,
        onSubmitRecordHandler: @escaping ([String: RecordFieldValue.Write]) async -> SubmitRecordResponse?,
        onUpdateRecordHandler: @escaping (Int, Int, [String: RecordFieldValue.Write]) async -> UpdateRecordResponse?,
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
                                guard let recordID, let revision else { return }
                                self.revision = await onUpdateRecordHandler(recordID, revision, fieldValues)?.revision
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
                $0[$1.code] = $1.attribute.recordFieldValue
            }
        }
    }
}
