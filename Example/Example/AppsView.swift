//
//  AppsView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct AppsView: View {
    var apps: [KintoneApp]

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(apps) { app in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("App ID: \(app.appID)")
                            Text("Code: \(app.code)")
                            Text("Name: \(app.name)")
                            Text("Description: \(app.description)")
                            Text("Space ID: \(String(optional: app.spaceID))")
                            Text("Thread ID: \(String(optional: app.threadID))")
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 4) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Created At: \(String(optional: app.createdAt?.description))")
                                Text("Code: \(app.creator.code)")
                                Text("Name: \(app.creator.name)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadiusBorder()
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Modified At: \(String(optional: app.modifiedAt))")
                                Text("Code: \(app.modifier.code)")
                                Text("Name: \(app.modifier.name)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadiusBorder()
                        }
                    }
                    .cornerRadiusBorder()
                }
            }
            .padding()
        }
    }
}

extension KintoneApp: Identifiable {
    public var id: Int { appID }
}
