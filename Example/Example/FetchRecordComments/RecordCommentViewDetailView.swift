//
//  RecordCommentViewDetailView.swift
//  Example
//
//  Created by ky0me22 on 2025/02/19.
//

import KintoneAPI
import SwiftUI

struct RecordCommentViewDetailView: View {
    var comment: RecordComment.Read

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CornerRadiusText("ID: \(comment.id)")
            HStack(alignment: .top) {
                Text("Text:")
                Divider()
                Text(comment.text)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadiusBorder()
            VStack(alignment: .leading, spacing: 4) {
                Text("Created At: \(comment.createdAt)")
                Text("Creator/Code: \(comment.creator.code)")
                Text("Creator/Name: \(String(optional: comment.creator.name))")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadiusBorder()
            if comment.mentions.isEmpty {
                CornerRadiusText("Mentions: Empty")
            } else {
                HStack(alignment: .top) {
                    Text("Mentions:")
                    Divider()
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(comment.mentions) { entity in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Code: \(entity.code)")
                                Text("Type: \(entity.type)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadiusBorder()
                        }
                    }
                }
                .cornerRadiusBorder()
            }
        }
        .cornerRadiusBorder()
    }
}
