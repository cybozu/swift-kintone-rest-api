//
//  FetchFormLayoutView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchFormLayoutView: View {
    var layoutChunks: [FormLayoutChunk]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(layoutChunks.indices, id: \.self) { i in
                    FormLayoutChunkView(layoutChunk: layoutChunks[i])
                }
            }
            .padding()
        }
    }
}
