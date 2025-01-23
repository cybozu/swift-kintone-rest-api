//
//  FetchFieldsView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchFieldsView: View {
    var fields: [FieldProperty]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(fields) { field in
                    FieldDetailView(field: field)
                }
            }
            .padding()
        }
    }
}
