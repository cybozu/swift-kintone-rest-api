//
//  AssigneeEntitiesView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct AssigneeEntitiesView: View {
    var entities: [AssigneeEntity]

    var body: some View {
        HStack(alignment: .top) {
            Text("Assignee Entities:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(entities.indices, id: \.self) { i in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Type: \(entities[i].type)")
                        Text("Code: \(String(optional: entities[i].code))")
                        Text("Include Subs: \(entities[i].includeSubs)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadiusBorder()
                }
            }
            if entities.isEmpty {
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .cornerRadiusBorder()
    }
}
