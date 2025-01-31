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
                    StatesView(states: statusSettings.states)
                    ActionsView(actions: statusSettings.actions)
                } else {
                    Spacer()
                }
            }
            .padding()
        }
    }
}
