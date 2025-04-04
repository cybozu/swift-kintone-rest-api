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
    @State private var isPresentedFileImporter = false
    @State private var isPresentedPhotosPicker = false
    @State private var pickerItem: PhotosPickerItem?
    @State private var fileArguments: FileArguments?
    @State private var fileKey: String?
    var uploadFileHandler: (FileArguments?) async -> UploadFileResponse?

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
                            isPresentedFileImporter = true
                        } label: {
                            Text("Select File")
                        }
                        Button {
                            isPresentedPhotosPicker = true
                        } label: {
                            Text("Select Image")
                        }
                        Button {
                            Task {
                                fileKey = await uploadFileHandler(fileArguments)?.fileKey
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
            isPresented: $isPresentedFileImporter,
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
        .photosPicker(
            isPresented: $isPresentedPhotosPicker,
            selection: $pickerItem,
            matching: .images
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
        fileArguments = FileArguments(
            fileName: fileName,
            mimeType: mimeType,
            data: data
        )
    }

    private func onChange(pickerItem: PhotosPickerItem?) {
        guard let pickerItem else { return }
        Task {
            guard let data = try await pickerItem.loadTransferable(type: Data.self),
                  let image = UIImage(data: data),
                  let jpegData = image.jpegData(compressionQuality: 1.0) else {
                return
            }
            fileArguments = FileArguments(
                fileName: "IMG_\(Date.now).jpeg",
                mimeType: UTType.jpeg.preferredMIMEType!,
                data: jpegData
            )
        }
    }
}
