//
//  EvaluateRecordPermissionsView.swift
//  Example
//
//  Created by ky0me22 on 2026/05/15.
//

import KintoneAPI
import SwiftUI

struct EvaluateRecordPermissionsView: View {
    @State private var isPresented = false
    @State private var permissionChunks = [RecordPermissionChunk]()
    var evaluateRecordPermissionsHandler: () async -> EvaluateRecordPermissionsResponse?

    var body: some View {
        HStack(alignment: .top) {
            Text("Permissions")
            Divider()
            Button {
                isPresented = true
            } label: {
                Text("Evaluate")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadiusBorder()
        .sheet(isPresented: $isPresented) {
            RecordPermissionsView(permissionChunks: permissionChunks)
                .task {
                    let response = await evaluateRecordPermissionsHandler()
                    permissionChunks = response?.recordPermissionChunks ?? []
                }
        }
    }
}
