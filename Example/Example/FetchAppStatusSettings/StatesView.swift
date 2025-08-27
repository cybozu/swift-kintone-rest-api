//
//  StatesView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct StatesView: View {
    var states: [RecordState]

    var body: some View {
        if states.isEmpty {
            CornerRadiusText("States: empty")
        } else {
            HStack(alignment: .top) {
                Text("States:")
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(states) { state in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name: \(state.name)")
                            Text("Index: \(state.index)")
                            Text("Assignee Type: \(state.assignee.type.rawValue)")
                            AssigneeEntitiesView(entities: state.assignee.entities)
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
