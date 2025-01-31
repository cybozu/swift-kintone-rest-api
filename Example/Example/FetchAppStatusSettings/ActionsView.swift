//
//  ActionsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct ActionsView: View {
    var actions: [StatusAction]

    var body: some View {
        if actions.isEmpty {
            CornerRadiusText("Actions: empty")
        } else {
            HStack(alignment: .top) {
                Text("Actions:")
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(actions) { action in
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
    }
}
