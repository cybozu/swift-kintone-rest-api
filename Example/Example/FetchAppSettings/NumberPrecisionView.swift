//
//  NumberPrecisionView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct NumberPrecisionView: View {
    var numberPrecision: NumberPrecision?

    var body: some View {
        HStack(alignment: .top) {
            Text("Number Precision:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                Text("Digits: \(String(optional: numberPrecision?.digits))")
                Text("Decimal Places: \(String(optional: numberPrecision?.decimalPlaces))")
                Text("Rounding Mode: \(String(optional: numberPrecision?.roundingMode.rawValue))")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadiusBorder()
        }
        .cornerRadiusBorder()
    }
}
