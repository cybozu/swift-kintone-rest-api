//
//  FetchAppsView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchAppsView: View {
    private var apps: [KintoneApp]

    init(appsResponse: FetchAppsResponse?) {
        apps = appsResponse?.apps ?? []
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(apps) { app in
                    HStack(alignment: .top) {
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
                                Text("Created At: \(app.createdAt)")
                                Text("Creator/Code: \(app.creator.code)")
                                Text("Creator/Name: \(String(optional: app.creator.name))")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadiusBorder()
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Modified At: \(app.modifiedAt)")
                                Text("Modifier/Code: \(app.modifier.code)")
                                Text("Modifier/Name: \(String(optional: app.modifier.name))")
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
