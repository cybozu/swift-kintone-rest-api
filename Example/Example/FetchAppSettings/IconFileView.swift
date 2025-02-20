//
//  IconFileView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct IconFileView: View {
    @State private var isPresented = false
    var icon: AppIcon.Read?
    var downloadFileHandler: (String) async -> Data?

    var body: some View {
        HStack(alignment: .top) {
            Text("Icon:")
            Divider()
            switch icon {
            case let .preset(key):
                Text(key)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case let .file(file):
                VStack(alignment: .leading, spacing: 4) {
                    CornerRadiusText("File Key: \(file.fileKey)")
                    CornerRadiusText("MIME Type: \(file.mimeType)")
                    CornerRadiusText("File Name: \(file.fileName)")
                    CornerRadiusText("File Size: \(file.fileSize)")
                    Button {
                        isPresented = true
                    } label: {
                        Text("Preview")
                    }
                }
                .sheet(isPresented: $isPresented) {
                    FilePreviewView {
                        await downloadFileHandler(file.fileKey)
                    }
                }
            case .none:
                Text("nil")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .cornerRadiusBorder()
    }
}
