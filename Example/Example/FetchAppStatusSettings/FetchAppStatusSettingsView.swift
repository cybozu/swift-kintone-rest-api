//
//  FetchAppStatusSettingsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct FetchAppStatusSettingsView: View {
    private var enable: Bool?
    private var states: [RecordState]
    private var actions: [StatusAction]
    private var revision: Int?

    init(appStatusSettingsResponse: FetchAppStatusSettingsResponse?) {
        enable = appStatusSettingsResponse?.enable
        states = appStatusSettingsResponse?.states ?? []
        actions = appStatusSettingsResponse?.actions ?? []
        revision = appStatusSettingsResponse?.revision
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                CornerRadiusText("Enable: \(String(optional: enable))")
                CornerRadiusText("Revision: \(String(optional: revision))")
                StatesView(states: states)
                ActionsView(actions: actions)
            }
            .padding()
        }
    }
}
