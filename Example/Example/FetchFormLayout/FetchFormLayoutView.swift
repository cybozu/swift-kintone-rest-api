//
//  FetchFormLayoutView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchFormLayoutView: View {
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
