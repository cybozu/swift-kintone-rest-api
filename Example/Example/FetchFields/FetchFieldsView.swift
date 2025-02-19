//
//  FetchFieldsView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import KintoneAPI
import SwiftUI

struct FetchFieldsView: View {
    private var fields: [Field]
    private var revision: Int?

    init(fieldsResponse: FetchFieldsResponse?) {
        fields = fieldsResponse?.fields ?? []
        revision = fieldsResponse?.revision
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(fields) { field in
                    FieldDetailView(field: field)
                }
                CornerRadiusText("Revision: \(String(optional: revision))")
            }
            .padding()
        }
    }
}
