//
//  FormLayoutView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FormLayoutView: View {
    var layout: [FormLayout]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(layout.indices, id: \.self) { i in
                    FormLayoutDetailView(layout: layout[i])
                }
            }
            .padding()
        }
    }
}

struct FormLayoutDetailView: View {
    var layout: FormLayout

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Type: \(layout.type)")
                Text("Code: \(String(optional: layout.code))")
                switch layout.type {
                case .row, .subtable:
                    Text("Fields: \(layout.fields.count)")
                case .group:
                    Text("Layout: \(layout.layout.count)")
                }
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                switch layout.type {
                case .row, .subtable:
                    ForEach(layout.fields.indices, id: \.self) { j in
                        let field = layout.fields[j]
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Type: \(field.type)")
                            Text("Code: \(String(optional: field.code))")
                            Text("Label: \(String(optional: field.label))")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadiusBorder()
                    }
                case .group:
                    ForEach(layout.layout.indices, id: \.self) { j in
                        FormLayoutDetailView(layout: layout.layout[j])
                    }
                }
            }
        }
        .cornerRadiusBorder()
    }
}
