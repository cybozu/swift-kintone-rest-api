//
//  RecordPermissionsView.swift
//  Example
//
//  Created by ky0me22 on 2026/05/15.
//

import KintoneAPI
import SwiftUI

struct RecordPermissionsView: View {
    var permissionChunks: [RecordPermissionChunk]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if permissionChunks.isEmpty {
                    CornerRadiusText("Permissions: Empty")
                } else {
                    ForEach(permissionChunks) { permissionChunk in
                        RecordPermissionChunkView(permissionChunk: permissionChunk)
                    }
                }
            }
            .padding()
        }
    }
}
