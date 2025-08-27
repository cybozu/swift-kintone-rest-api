//
//  FormLayoutPropertyView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct FormLayoutChunkView: View {
    var layoutChunk: FormLayoutChunk

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Type: \(layoutChunk.type.rawValue)")
                Text("Code: \(String(optional: layoutChunk.code))")
                switch layoutChunk.type {
                case .row, .subtable:
                    Text("Fields: \(layoutChunk.fields.count)")
                case .group:
                    Text("Layout: \(layoutChunk.layoutChunks.count)")
                }
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                switch layoutChunk.type {
                case .row, .subtable:
                    ForEach(layoutChunk.fields.indices, id: \.self) { j in
                        let field = layoutChunk.fields[j]
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Type: \(field.type.rawValue)")
                            Text("Code: \(String(optional: field.code))")
                            Text("Label: \(String(optional: field.label))")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadiusBorder()
                    }
                case .group:
                    ForEach(layoutChunk.layoutChunks.indices, id: \.self) { j in
                        FormLayoutChunkView(layoutChunk: layoutChunk.layoutChunks[j])
                    }
                }
            }
        }
        .cornerRadiusBorder()
    }
}
