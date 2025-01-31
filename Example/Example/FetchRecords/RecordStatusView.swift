//
//  RecordStatusView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct RecordStatusView: View {
    var state: String
    var actions: [StatusAction]
    var updateStatusHandler: (StatusAction) async -> Void

    var body: some View {
        if let action = actions.first(where: { $0.from == state }) {
            HStack {
                Text("Value: \(state)")
                Spacer()
                Button {
                    Task {
                        await updateStatusHandler(action)
                    }
                } label: {
                    Text(action.name)
                }
            }
            .cornerRadiusBorder()
        } else {
            CornerRadiusText("Value: \(state)")
        }
    }
}
