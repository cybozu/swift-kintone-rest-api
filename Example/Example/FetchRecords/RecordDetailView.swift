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
    var fetchRecordCommentsHandler: (Int) async -> FetchRecordCommentsResponse?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(record.fields) { recordField in
                RecordFieldView(
                    recordField: recordField,
                    actions: actions,
                    updateStatusHandler: {
                        if let id = record.identity?.id {
                            await updateStatusHandler(RecordIdentity.Write(id: id), $0)
                        }
                    },
                    downloadFileHandler: downloadFileHandler
                )
            }
            FetchRecordCommentsView {
                guard let id = record.identity?.id else { return nil }
                return await fetchRecordCommentsHandler(id)
            }
        }
        .cornerRadiusBorder()
    }
}
