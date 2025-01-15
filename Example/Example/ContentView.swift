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
    case apps
    case formLayout
    case fields
    case record
}

@MainActor @Observable final class ContentViewModel {
    var domain: String
    var loginName: String
    var password = ""
    var appID: Int
    var isPresented = false
    var tabCategory = TabCategory.apps
    var apps = [KintoneApp]()
    var layout = [FormLayout]()
    var fields = [FieldProperty]()

    var kintoneAPI: KintoneAPI {
        .init(
            authenticationMethod: .cybozuAuthorization(.init(loginName: loginName, password: password)),
            dataRequestHandler: { [domain] request in
                try await URLSession.shared.data(for: request.inserted(domain: domain))
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
        } catch {
            print(error.localizedDescription)
        }
    }

    func onSubmit(fields: [RecordField]) async {
        do {
            try await kintoneAPI.submitRecord(appID: appID, fields: fields)
        } catch {
            print(error.localizedDescription)
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
                    AppsView(apps: viewModel.apps)
                        .tabItem {
                            Label("Apps", systemImage: "app.fill")
                        }
                        .tag(TabCategory.apps)
                    FormLayoutView(layout: viewModel.layout)
                        .tabItem {
                            Label("Form Layout", systemImage: "square.grid.2x2")
                        }
                        .tag(TabCategory.formLayout)
                    FieldsView(fields: viewModel.fields)
                        .tabItem {
                            Label("Fields", systemImage: "square.3.layers.3d.down.left")
                        }
                        .tag(TabCategory.fields)
                    RecordView(fields: viewModel.fields) { fields in
                        Task {
                            await viewModel.onSubmit(fields: fields)
                        }
                    }
                    .tabItem {
                        Label("Submit Record", systemImage: "paperplane")
                    }
                    .tag(TabCategory.record)
                }
                .navigationTitle("kintone API")
                .task {
                    await viewModel.onTask()
                }
            }
        }
    }
}
