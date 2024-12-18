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
                    let layout = layout[i]
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Type: \(layout.type)")
                            Text("Code: \(String(optional: layout.code))")
                            Text("Fields: \(layout.fields.count)")
                            Spacer()
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 4) {
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
                        }
                    }
                    .cornerRadiusBorder()
                }
            }
            .padding()
        }
    }
}
