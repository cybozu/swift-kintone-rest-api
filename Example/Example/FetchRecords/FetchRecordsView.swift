//
//  FetchRecordsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FetchRecordsView: View {
    private var records: [Record.Read]
    private var actions: [StatusAction]
    private var updateStatusHandler: (RecordIdentity.Write, StatusAction) async -> Void
    private var downloadFileHandler: (String) async -> Data?
    private var fetchRecordCommentsHandler: (Int) async -> FetchRecordCommentsResponse?

    init(
        recordsResponse: FetchRecordsResponse?,
        appStatusSettingsResponse: FetchAppStatusSettingsResponse?,
        updateStatusHandler: @escaping (RecordIdentity.Write, StatusAction) async -> Void,
        downloadFileHandler: @escaping (String) async -> Data?,
        fetchRecordCommentsHandler: @escaping (Int) async -> FetchRecordCommentsResponse?
    ) {
        records = recordsResponse?.records ?? []
        actions = appStatusSettingsResponse?.actions ?? []
        self.updateStatusHandler = updateStatusHandler
        self.downloadFileHandler = downloadFileHandler
        self.fetchRecordCommentsHandler = fetchRecordCommentsHandler
    }

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
