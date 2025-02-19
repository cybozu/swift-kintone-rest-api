//
//  RecordCommentsView.swift
//  Example
//
//  Created by ky0me22 on 2025/02/19.
//

import KintoneAPI
import SwiftUI

struct RecordCommentsView: View {
    var comments: [RecordComment.Read]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if comments.isEmpty {
                    CornerRadiusText("Comments: Empty")
                } else {
                    ForEach(comments) { comment in
                        RecordCommentViewDetailView(comment: comment)
                    }
                }
            }
            .padding()
        }
    }
}
