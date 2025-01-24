//
//  FilePreviewView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/24.
//

import KintoneAPI
import SwiftUI

struct FilePreviewView: View {
    @State private var data: Data?
    var downloadFileHandler: () async -> Data?
    
    var body: some View {
        Group {
            if let data {
                if let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Not Image")
                }
            } else {
                ProgressView()
            }
        }
        .frame(width: 250, height: 250)
        .task {
            data = await downloadFileHandler()
        }
    }
}
