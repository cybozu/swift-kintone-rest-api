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
        VStack {
            Button {
                isPresented = true
            } label: {
                Text("Select File")
            }
            .fileImporter(
                isPresented: $isPresented,
                allowedContentTypes: [.image],
                onCompletion: { result in
                    switch result {
                    case let .success(url):
                        onCompletion(url: url)
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
            )
            Text("or")
            PhotosPicker(selection: $pickerItem, matching: .images) {
                Text("Select Image")
            }
            .onChange(of: pickerItem) { _, newValue in
                onChange(pickerItem: newValue)
            }
            Button {
                Task {
                    fileKey = await uploadFileHandler(fileArguments)
                }
            } label: {
                Text("Upload")
            }
            .buttonStyle(.borderedProminent)
            Text("File Name: \(fileArguments?.fileName ?? "nil")")
            Text("MEME Type: \(fileArguments?.mimeType ?? "nil")")
            Text("File Key: \(fileKey ?? "nil")")
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

struct DataURL: Transferable {
    var url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .data) { data in
            SentTransferredFile(data.url)
        } importing: { received in
            Self(url: received.file)
        }
    }
}
