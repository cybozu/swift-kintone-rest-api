//
//  UploadFileView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/24.
//

import KintoneAPI
import PhotosUI
import SwiftUI

struct UploadFileView: View {
    @State private var isPresented = false
    @State private var pickerItem: PhotosPickerItem?
    @State private var fileArguments: FileArguments?
    @State private var fileKey: String?
    var uploadFileHandler: (FileArguments?) async -> String?

    var body: some View {
        Form {
            Section {
                Text("File Name: \(fileArguments?.fileName ?? "nil")")
                Text("MEME Type: \(fileArguments?.mimeType ?? "nil")")
                Text("File Key: \(fileKey ?? "nil")")
            }
            Section {
                LabeledContent {
                    HStack {
                        Button {
                            isPresented = true
                        } label: {
                            Text("Select File")
                        }
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            Text("Select Image")
                        }
                        Button {
                            Task {
                                fileKey = await uploadFileHandler(fileArguments)
                            }
                        } label: {
                            Text("Upload")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                } label: {
                    EmptyView()
                }
            }
        }
        .fileImporter(
            isPresented: $isPresented,
            allowedContentTypes: [.text],
            onCompletion: { result in
                switch result {
                case let .success(url):
                    onCompletion(url: url)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        )
        .onChange(of: pickerItem) { _, newValue in
            onChange(pickerItem: newValue)
        }
    }

    private func onCompletion(url: URL) {
        guard url.startAccessingSecurityScopedResource() else { return }
        defer {
            url.stopAccessingSecurityScopedResource()
        }
        let fileName = url.lastPathComponent
        guard let mimeType = UTType(filenameExtension: url.pathExtension)?.preferredMIMEType,
              let data = try? Data(contentsOf: url) else {
            return
        }
        fileArguments = FileArguments(fileName: fileName, mimeType: mimeType, data: data)
    }

    private func onChange(pickerItem: PhotosPickerItem?) {
        guard let pickerItem else { return }
        Task {
            guard let url = try await pickerItem.loadTransferable(type: DataURL.self)?.url else { return }
            let fileName = url.lastPathComponent
            guard let mimeType = UTType(filenameExtension: url.pathExtension)?.preferredMIMEType,
                  let data = try await pickerItem.loadTransferable(type: Data.self) else {
                return
            }
            fileArguments = FileArguments(fileName: fileName, mimeType: mimeType, data: data)
        }
    }
}
