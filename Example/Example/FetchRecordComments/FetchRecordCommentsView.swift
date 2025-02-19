//
//  FetchRecordCommentsView.swift
//  Example
//
//  Created by ky0me22 on 2025/02/19.
//

import KintoneAPI
import SwiftUI

struct FetchRecordCommentsView: View {
    @State private var isPresented = false
    @State private var comments = [RecordComment.Read]()
    var fetchRecordCommentsHandler: () async -> [RecordComment.Read]

    var body: some View {
        HStack(alignment: .top) {
            Text("Comments:")
            Divider()
            Button {
                isPresented = true
            } label: {
                Text("Fetch")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadiusBorder()
        .sheet(isPresented: $isPresented) {
            RecordCommentsView(comments: comments)
                .task {
                    comments = await fetchRecordCommentsHandler()
                }
        }
    }
}
