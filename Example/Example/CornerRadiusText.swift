//
//  CornerRadiusText.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import SwiftUI

struct CornerRadiusText: View {
    var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadiusBorder()
    }
}
