//
//  RecordView.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import SwiftUI

struct RecordView: View {
    var tapButtonHandler: () -> Void

    var body: some View {
        VStack {
            Button {
                tapButtonHandler()
            } label: {
                Text("Submit")
            }
        }
    }
}
