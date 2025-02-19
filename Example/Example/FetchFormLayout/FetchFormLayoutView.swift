//
//  FetchFormLayoutView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchFormLayoutView: View {
    var layoutProperties: [FormLayoutProperty]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(layoutProperties.indices, id: \.self) { i in
                    FormLayoutPropertyView(layoutProperty: layoutProperties[i])
                }
            }
            .padding()
        }
    }
}
