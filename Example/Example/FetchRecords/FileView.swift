//
//  FileView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FileView: View {
    @State private var isPresented = false
    var file: File.Read
    var downloadFileHandler: (String) async -> Data?
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Value:")
            Divider()
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
        }
        .cornerRadiusBorder()
        .sheet(isPresented: $isPresented) {
            FilePreviewView {
                await downloadFileHandler(file.fileKey)
            }
        }
    }
}

