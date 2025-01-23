//
//  OptionsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct OptionsView: View {
    var options: [FieldOption]

    var body: some View {
        HStack(alignment: .top) {
            Text("Options:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                ForEach(options) { option in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Label: \(option.label)")
                        Text("Index: \(option.index)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadiusBorder()
                }
            }
            if options.isEmpty {
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .cornerRadiusBorder()
    }
}
