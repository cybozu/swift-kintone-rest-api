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
    var actions: [StatusAction]
    var updateStatusHandler: (RecordIdentity.Write, StatusAction) async -> Void
    var downloadFileHandler: (String) async -> Data?
    var fetchRecordCommentsHandler: (Int) async -> RecordComments?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(records.indices, id: \.self) { i in
                    RecordDetailView(
                        record: records[i],
                        actions: actions,
                        updateStatusHandler: updateStatusHandler,
                        downloadFileHandler: downloadFileHandler,
                        fetchRecordCommentsHandler: fetchRecordCommentsHandler
                    )
                }
            }
            .padding()
        }
    }
}
