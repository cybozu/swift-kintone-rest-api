//
//  RecordDetailView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct RecordDetailView: View {
    var record: Record.Read
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(record.fields) { recordField in
                RecordFieldView(recordField: recordField)
            }
        }
        .cornerRadiusBorder()
    }
}
