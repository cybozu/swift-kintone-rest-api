//
//  EntitiesView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct EntitiesView: View {
    var label: String
    var entities: [Entity.Read]

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(entities) { entity in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Code: \(entity.code)")
                        Text("Type: \(entity.type.rawValue)")
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
