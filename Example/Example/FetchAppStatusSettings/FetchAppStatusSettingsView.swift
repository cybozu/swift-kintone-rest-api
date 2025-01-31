//
//  FetchAppStatusSettingsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct FetchAppStatusSettingsView: View {
    var statusSettings: AppStatusSettings?

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if let statusSettings {
                    CornerRadiusText("Enable: \(statusSettings.enable)")
                    CornerRadiusText("Revision: \(statusSettings.revision)")
                    if statusSettings.states.isEmpty {
                        CornerRadiusText("States: empty")
                    } else {
                        HStack(alignment: .top) {
                            Text("States:")
                            Divider()
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(statusSettings.states) { state in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Name: \(state.name)")
                                        Text("Index: \(state.index)")
                                        Text("Assignee Type: \(state.assignee.type)")
                                        HStack(alignment: .top) {
                                            Text("Assignee Entities:")
                                            Divider()
                                            VStack(alignment: .leading, spacing: 4) {
                                                ForEach(state.assignee.entities) { entity in
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        Text("Type: \(entity.type)")
                                                        Text("Code: \(entity.code)")
                                                        Text("Include Subs: \(entity.includeSubs)")
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .cornerRadiusBorder()
                                                }
                                            }
                                            if state.assignee.entities.isEmpty {
                                                Spacer().frame(maxWidth: .infinity)
                                            }
                                        }
                                        .cornerRadiusBorder()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .cornerRadiusBorder()
                                }
                            }
                        }
                        .cornerRadiusBorder()
                    }
                    if statusSettings.actions.isEmpty {
                        CornerRadiusText("Actions: empty")
                    } else {
                        HStack(alignment: .top) {
                            Text("Actions:")
                            Divider()
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(statusSettings.actions) { action in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Name: \(action.name)")
                                        Text("From: \(action.from)")
                                        Text("To: \(action.to)")
                                        Text("Filter Condition: \(action.filterCondition)")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .cornerRadiusBorder()
                                }
                            }
                        }
                        .cornerRadiusBorder()
                    }
                } else {
                    Spacer()
                }
            }
            .padding()
        }
    }
}
