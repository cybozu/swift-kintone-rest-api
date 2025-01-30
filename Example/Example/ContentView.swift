//
//  ContentView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import Observation
import SwiftUI

enum TabCategory {
    case fetchApps
    case fetchFormLayout
    case fetchFields
    case fetchRecords
    case submitRecord
    case uploadFile
}

@MainActor @Observable final class ContentViewModel {
    var domain: String
    var loginName: String
    var password = ""
    var appID: Int
    var isPresented = false
    var tabCategory = TabCategory.fetchApps
    var apps = [KintoneApp]()
    var layout = [FormLayout]()
    var fields = [FieldProperty]()
    var records = [Record.Read]()

    var kintoneAPI: KintoneAPI {
        .init(
            authenticationMethod: .cybozuAuthorization(.init(loginName: loginName, password: password)),
            dataRequestHandler: { [domain] request in
                guard let url = request.url else { throw URLError(.badURL) }
                var request = request
                request.url = URL(string: "https://\(domain)\(url.relativeString)")
                return try await URLSession.shared.data(for: request)
            }
        )
    }

    init() {
        domain = UserDefaults.standard.string(forKey: "domain") ?? ""
        loginName = UserDefaults.standard.string(forKey: "loginName") ?? ""
        appID = UserDefaults.standard.integer(forKey: "appID")
    }

    func onNext() {
        UserDefaults.standard.set(domain, forKey: "domain")
        UserDefaults.standard.set(loginName, forKey: "loginName")
        UserDefaults.standard.set(appID, forKey: "appID")
        isPresented = true
    }

    func onTask() async {
        do {
            apps = try await kintoneAPI.fetchApps()
            layout = try await kintoneAPI.fetchFormLayout(appID: appID)
            fields = try await kintoneAPI.fetchFields(appID: appID)
            records = try await kintoneAPI.fetchRecords(appID: appID)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func downloadFile(fileKey: String) async -> Data? {
        do {
            return try await kintoneAPI.downloadFile(fileKey: fileKey)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func onSubmitRecord(fields: [String: RecordFieldValue.Write]) async -> RecordIdentity.Read? {
        do {
            let fields = fields.compactMap { RecordField.Write(code: $0.key, value: $0.value) }
            let record = Record.Write(fields: fields)
            return try await kintoneAPI.submitRecord(appID: appID, record: record)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func onUpdateRecord(recordID: Int, fields: [String: RecordFieldValue.Write]) async -> RecordIdentity.Read? {
        do {
            let recordIdentity = RecordIdentity.Write(id: recordID)
            let fields = fields.compactMap { RecordField.Write(code: $0.key, value: $0.value) }
            let record = Record.Write(fields: fields)
            return try await kintoneAPI.updateRecord(appID: appID, recordIdentity: recordIdentity, record: record)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func onRemoveRecord(recordID: Int) async {
        do {
            let recordIdentity = RecordIdentity.Write(id: recordID)
            try await kintoneAPI.removeRecords(appID: appID, recordIdentities: [recordIdentity])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func uploadFile(fileArguments: FileArguments?) async -> String? {
        guard let fileArguments else { return nil }
        do {
            return try await kintoneAPI.uploadFile(
                fileName: fileArguments.fileName,
                mimeType: fileArguments.mimeType,
                data: fileArguments.data
            )
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

@MainActor struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent {
                        TextField("subdomain.cybozu.com", text: $viewModel.domain)
                            .multilineTextAlignment(.trailing)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } label: {
                        Text("Domain:")
                    }
                    LabeledContent {
                        TextField("user", text: $viewModel.loginName)
                            .multilineTextAlignment(.trailing)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } label: {
                        Text("Login Name:")
                    }
                    LabeledContent {
                        SecureField("password", text: $viewModel.password)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("Password:")
                    }
                    LabeledContent {
                        TextField("1", value: $viewModel.appID, format: .number)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("App ID:")
                    }
                }
                Section {
                    LabeledContent {
                        Button {
                            viewModel.onNext()
                        } label: {
                            Text("Next")
                        }
                        .buttonStyle(.borderedProminent)
                    } label: {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Entrance")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.isPresented) {
                TabView(selection: $viewModel.tabCategory) {
                    FetchAppsView(apps: viewModel.apps)
                        .tabItem {
                            Label("Apps", systemImage: "app.fill")
                        }
                        .tag(TabCategory.fetchApps)
                    FetchFormLayoutView(layout: viewModel.layout)
                        .tabItem {
                            Label("Form Layout", systemImage: "square.grid.2x2")
                        }
                        .tag(TabCategory.fetchFormLayout)
                    FetchFieldsView(fields: viewModel.fields)
                        .tabItem {
                            Label("Fields", systemImage: "square.3.layers.3d.down.left")
                        }
                        .tag(TabCategory.fetchFields)
                    FetchRecordsView(records: viewModel.records) { fileKey in
                        await viewModel.downloadFile(fileKey: fileKey)
                    }
                    .tabItem {
                        Label("Records", systemImage: "document.on.document")
                    }
                    .tag(TabCategory.fetchRecords)
                    SubmitRecordView(
                        fields: viewModel.fields,
                        onSubmitRecordHandler: { fields in
                            await viewModel.onSubmitRecord(fields: fields)
                        },
                        onUpdateRecordHandler: { recordID, fields in
                            await viewModel.onUpdateRecord(recordID: recordID, fields: fields)
                        },
                        onRemoveRecordHandler: { recordID in
                            await viewModel.onRemoveRecord(recordID: recordID)
                        }
                    )
                    .tabItem {
                        Label("Submit Record", systemImage: "paperplane")
                    }
                    .tag(TabCategory.submitRecord)
                    UploadFileView { fileArguments in
                        await viewModel.uploadFile(fileArguments: fileArguments)
                    }
                    .tabItem {
                        Label("Upload File", systemImage: "square.and.arrow.up")
                    }
                    .tag(TabCategory.uploadFile)
                }
                .navigationTitle("kintone API")
                .task {
                    await viewModel.onTask()
                }
            }
        }
    }
}
