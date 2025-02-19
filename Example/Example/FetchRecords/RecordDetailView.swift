//
//  RecordDetailView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct RecordDetailView: View {
    var record: Record.Read
    var actions: [StatusAction]
    var updateStatusHandler: (RecordIdentity.Write, StatusAction) async -> Void
    var downloadFileHandler: (String) async -> Data?
    var fetchRecordCommentsHandler: (Int) async -> RecordComments?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(record.fields) { recordField in
                RecordFieldView(
                    recordField: recordField,
                    actions: actions,
                    updateStatusHandler: {
                        let recordIdentity = RecordIdentity.Write(id: record.identity.id)
                        await updateStatusHandler(recordIdentity, $0)
                    },
                    downloadFileHandler: downloadFileHandler
                )
            }
            FetchRecordCommentsView {
                await fetchRecordCommentsHandler(record.identity.id)
            }
        }
        .cornerRadiusBorder()
    }
}
