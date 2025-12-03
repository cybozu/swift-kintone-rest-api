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
    var appsResponse: FetchAppsResponse?
    var formLayoutResponse: FetchFormLayoutResponse?
    var fieldsResponse: FetchFieldsResponse?
    var appSettingsResponse: FetchAppSettingsResponse?
    var recordsResponse: FetchRecordsResponse?
    var appStatusSettingsResponse: FetchAppStatusSettingsResponse?

    var kintoneAPI: KintoneAPI {
        .init(
            authenticationMethod: .cybozuAuthorization(.init(loginName: loginName, password: password)),
            baseURL: { [domain] in
                URL(string: "https://\(domain)")!
            },
            dataRequestHandler: { request in
                try await URLSession.shared.data(for: request)
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
            appsResponse = try await kintoneAPI.fetchApps()
            formLayoutResponse = try await kintoneAPI.fetchFormLayout(appID: appID)
            fieldsResponse = try await kintoneAPI.fetchFields(appID: appID)
            appSettingsResponse = try await kintoneAPI.fetchAppSettings(appID: appID)
            recordsResponse = try await kintoneAPI.fetchRecords(appID: appID)
            appStatusSettingsResponse = try await kintoneAPI.fetchAppStatusSettings(appID: appID)
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchRecordComments(recordID: Int) async -> FetchRecordCommentsResponse? {
        do {
            return try await kintoneAPI.fetchRecordComments(appID: appID, recordID: recordID)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func updateStatus(recordIdentity: RecordIdentity.Write, action: StatusAction) async {
        do {
            let assignee = appStatusSettingsResponse?.states.first(where: { $0.name == action.to })?.assignee.entities.first?.code
            try await kintoneAPI.updateStatus(appID: appID, recordIdentity: recordIdentity, actionName: action.name, assignee: assignee)
            recordsResponse = try await kintoneAPI.fetchRecords(appID: appID)
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

    func onSubmitRecord(fields: [String: RecordFieldValue.Write]) async -> SubmitRecordResponse? {
        do {
            let fields = fields.compactMap { RecordField.Write(code: $0.key, value: $0.value) }
            let record = Record.Write(fields: fields)
            return try await kintoneAPI.submitRecord(appID: appID, record: record)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func onUpdateRecord(recordID: Int, revision: Int, fields: [String: RecordFieldValue.Write]) async -> UpdateRecordResponse? {
        do {
            let recordIdentity = RecordIdentity.Write(id: recordID, revision: revision)
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

    func uploadFile(fileArguments: FileArguments?) async -> UploadFileResponse? {
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
                            .textContentType(.URL)
                    } label: {
                        Text("Domain:")
                    }
                    LabeledContent {
                        TextField("user", text: $viewModel.loginName)
                            .multilineTextAlignment(.trailing)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .textContentType(.username)
                    } label: {
                        Text("Login Name:")
                    }
                    LabeledContent {
                        SecureField("password", text: $viewModel.password)
                            .multilineTextAlignment(.trailing)
                            .textContentType(.password)
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
                        HStack {
                            Spacer()
                            Button {
                                viewModel.onNext()
                            } label: {
                                Text("Next")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    } label: {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Entrance")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.isPresented) {
                TabView(selection: $viewModel.tabCategory) {
                    FetchAppsView(
                        appsResponse: viewModel.appsResponse
                    )
                    .tabItem {
                        Label("Apps", systemImage: "app.fill")
                    }
                    .tag(TabCategory.fetchApps)
                    FetchFormLayoutView(
                        formLayoutResponse: viewModel.formLayoutResponse
                    )
                    .tabItem {
                        Label("Form Layout", systemImage: "square.grid.2x2")
                    }
                    .tag(TabCategory.fetchFormLayout)
                    FetchFieldsView(
                        fieldsResponse: viewModel.fieldsResponse
                    )
                    .tabItem {
                        Label("Fields", systemImage: "square.3.layers.3d.down.left")
                    }
                    .tag(TabCategory.fetchFields)
                    FetchAppSettingsView(
                        appSettingsResponse: viewModel.appSettingsResponse,
                        downloadFileHandler: { fileKey in
                            await viewModel.downloadFile(fileKey: fileKey)
                        }
                    )
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(TabCategory.fetchAppSettings)
                    FetchRecordsView(
                        recordsResponse: viewModel.recordsResponse,
                        appStatusSettingsResponse: viewModel.appStatusSettingsResponse,
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
                        fieldsResponse: viewModel.fieldsResponse,
                        onSubmitRecordHandler: { fields in
                            await viewModel.onSubmitRecord(fields: fields)
                        },
                        onUpdateRecordHandler: { recordID, revision, fields in
                            await viewModel.onUpdateRecord(recordID: recordID, revision: revision, fields: fields)
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
                    FetchAppStatusSettingsView(
                        appStatusSettingsResponse: viewModel.appStatusSettingsResponse
                    )
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
