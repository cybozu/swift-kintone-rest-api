//
//  ContentView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import Observation
import SwiftUI

@MainActor @Observable final class ContentViewModel {
    private let domain = ""
    private let credentials = Credentials(loginName: "", password: "")
    private let appID = 1
    private let kintoneAPI: KintoneAPI
    var tabCategory = TabCategory.apps
    var apps = [KintoneApp]()
    var layout = [FormLayout]()
    var fields = [FieldProperty]()

    init() {
        kintoneAPI = KintoneAPI(
            domain: .absolute(domain),
            authenticationMethod: .cybozuAuthorization(credentials),
            dataRequestHandler: { request in
                try await URLSession.shared.data(for: request)
            }
        )
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

    func onTapSubmitButton() async {
        do {
            let fields: [RecordField] = [
                .init(code: "リッチエディター", value: .richText("<h1>hello world</h1>")),
                .init(code: "文字列_複数行", value: .richText("Hello\nWorld\nTuru")),
                .init(code: "文字列_1行", value: .singleLineText("お腹すいた")),
                .init(code: "数値", value: .number("123456789")),
                .init(code: "リンク_URL", value: .link("http://hoge")),
                .init(code: "リンク_電話番号", value: .link("hoge")),
                .init(code: "リンク_メール", value: .link("a@b")),
                .init(code: "ラジオボタン", value: .radioButton("sample2")),
                .init(code: "チェックボックス", value: .checkBox(["sample1"])),
                .init(code: "ドロップダウン", value: .dropDown("sample2")),
                .init(code: "複数選択", value: .multiSelect(["sample2", "sample4"])),
                .init(code: "ユーザー選択", value: .userSelect([CodeObject(code: "cybozu")])),
                .init(code: "組織選択", value: .organizationSelect([CodeObject(code: "SecretSociety")])),
                .init(code: "グループ選択", value: .groupSelect([CodeObject(code: "everyone")])),
                .init(code: "日付", value: .date(Date.now)),
                .init(code: "時刻", value: .time(Time(hour: 10, minute: 30))),
                .init(code: "日時", value: .dateTime(Date())),
            ]
            try await kintoneAPI.submitRecord(appID: appID, fields: fields)
        } catch {
            print(error.localizedDescription)
        }
    }
}

@MainActor struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        TabView(selection: $viewModel.tabCategory) {
            AppsView(apps: viewModel.apps)
                .tabItem {
                    Label("アプリ一覧", systemImage: "app.fill")
                }
                .tag(TabCategory.apps)
            FormLayoutView(layout: viewModel.layout)
                .tabItem {
                    Label("フォームレイアウト", systemImage: "square.grid.2x2")
                }
                .tag(TabCategory.formLayout)
            FieldsView(fields: viewModel.fields)
                .tabItem {
                    Label("フィールド一覧", systemImage: "square.3.layers.3d.down.left")
                }
                .tag(TabCategory.fields)
            RecordView {
                Task {
                    await viewModel.onTapSubmitButton()
                }
            }
            .tabItem {
                Label("レコード登録", systemImage: "paperplane")
            }
            .tag(TabCategory.record)
        }
        .task {
            await viewModel.onTask()
        }
    }
}

enum TabCategory {
    case apps
    case formLayout
    case fields
    case record
}
