//
//  FormLayoutPropertyView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FormLayoutPropertyView: View {
    var layoutProperty: FormLayoutProperty

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Type: \(layoutProperty.type)")
                Text("Code: \(String(optional: layoutProperty.code))")
                switch layoutProperty.type {
                case .row, .subtable:
                    Text("Fields: \(layoutProperty.fields.count)")
                case .group:
                    Text("Layout: \(layoutProperty.layoutProperties.count)")
                }
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                switch layoutProperty.type {
                case .row, .subtable:
                    ForEach(layoutProperty.fields.indices, id: \.self) { j in
                        let field = layoutProperty.fields[j]
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Type: \(field.type)")
                            Text("Code: \(String(optional: field.code))")
                            Text("Label: \(String(optional: field.label))")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadiusBorder()
                    }
                case .group:
                    ForEach(layoutProperty.layoutProperties.indices, id: \.self) { j in
                        FormLayoutPropertyView(layoutProperty: layoutProperty.layoutProperties[j])
                    }
                }
            }
        }
        .cornerRadiusBorder()
    }
}
