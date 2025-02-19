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
    case fetchAppSettings
    case fetchRecords
    case submitRecord
    case uploadFile
    case status
}

@MainActor @Observable final class ContentViewModel {
    var domain: String
    var loginName: String
    var password = ""
    var appID: Int
    var isPresented = false
    var tabCategory = TabCategory.fetchApps
    var apps = [KintoneApp]()
    var layoutChunks = [FormLayoutChunk]()
    var fields = [Field]()
    var appSettings: AppSettings?
    var records = [Record.Read]()
    var statusSettings: AppStatusSettings?

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
            layoutChunks = try await kintoneAPI.fetchFormLayout(appID: appID).layoutChunks
            fields = try await kintoneAPI.fetchFields(appID: appID).fields
            appSettings = try await kintoneAPI.fetchAppSettings(appID: appID)
            records = try await kintoneAPI.fetchRecords(appID: appID).records
            statusSettings = try await kintoneAPI.fetchAppStatusSettings(appID: appID).appStatusSettings
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchRecordComments(recordID: Int) async -> [RecordComment.Read] {
        do {
            return try await kintoneAPI.fetchRecordComments(appID: appID, recordID: recordID).comments
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func updateStatus(recordIdentity: RecordIdentity.Write, action: StatusAction) async {
        do {
            let assignee = statusSettings?.states.first(where: { $0.name == action.to })?.assignee.entities.first?.code
            try await kintoneAPI.updateStatus(appID: appID, recordIdentity: recordIdentity, actionName: action.name, assignee: assignee)
            records = try await kintoneAPI.fetchRecords(appID: appID).records
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
            return try await kintoneAPI.submitRecord(appID: appID, record: record).recordIdentity
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func onUpdateRecord(recordID: Int, fields: [String: RecordFieldValue.Write]) async -> Int? {
        do {
            let recordIdentity = RecordIdentity.Write(id: recordID)
            let fields = fields.compactMap { RecordField.Write(code: $0.key, value: $0.value) }
            let record = Record.Write(fields: fields)
            return try await kintoneAPI.updateRecord(appID: appID, recordIdentity: recordIdentity, record: record).revision
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
            ).fileKey
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
                    FetchFormLayoutView(layoutChunks: viewModel.layoutChunks)
                        .tabItem {
                            Label("Form Layout", systemImage: "square.grid.2x2")
                        }
                        .tag(TabCategory.fetchFormLayout)
                    FetchFieldsView(fields: viewModel.fields)
                        .tabItem {
                            Label("Fields", systemImage: "square.3.layers.3d.down.left")
                        }
                        .tag(TabCategory.fetchFields)
                    FetchAppSettingsView(
                        appSettings: viewModel.appSettings,
                        downloadFileHandler: { fileKey in
                            await viewModel.downloadFile(fileKey: fileKey)
                        }
                    )
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(TabCategory.fetchAppSettings)
                    FetchRecordsView(
                        records: viewModel.records,
                        actions: viewModel.statusSettings?.actions ?? [],
                        updateStatusHandler: { recordIdentity, action in
                            await viewModel.updateStatus(recordIdentity: recordIdentity, action: action)
                        },
                        downloadFileHandler: { fileKey in
                            await viewModel.downloadFile(fileKey: fileKey)
                        },
                        fetchRecordCommentsHandler: { recordID in
                            await viewModel.fetchRecordComments(recordID: recordID)
                        }
                    )
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
                    FetchAppStatusSettingsView(statusSettings: viewModel.statusSettings)
                        .tabItem {
                            Label("Status", systemImage: "point.bottomleft.forward.to.arrow.triangle.scurvepath.fill")
                        }
                        .tag(TabCategory.status)
                }
                .navigationTitle("kintone API")
                .task {
                    await viewModel.onTask()
                }
            }
        }
    }
}
