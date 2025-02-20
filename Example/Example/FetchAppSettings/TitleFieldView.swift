//
//  TitleFieldView.swift
//  Example
//
//  Created by ky0me22 on 2025/02/04.
//

import KintoneAPI
import SwiftUI

struct TitleFieldView: View {
    var titleField: TitleField?

    var body: some View {
        HStack(alignment: .top) {
            Text("Title Field:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                Text("Selection Mode: \(String(optional: titleField?.selectionMode.rawValue))")
                Text("Code: \(String(optional: titleField?.code))")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadiusBorder()
        }
        .cornerRadiusBorder()
    }
}
