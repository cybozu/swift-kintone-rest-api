//
//  FieldMappingsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FieldMappingsView: View {
    var fieldMappings: [FieldMapping]

    var body: some View {
        HStack(alignment: .top) {
            Text("Field Mappings:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(fieldMappings.indices, id: \.self) { j in
                    let fieldMapping = fieldMappings[j]
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Field: \(fieldMapping.field)")
                        Text("Related Field: \(fieldMapping.relatedField)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadiusBorder()
                }
            }
            if fieldMappings.isEmpty {
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .cornerRadiusBorder()
    }
}
