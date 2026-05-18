//
//  RecordPermissionChunkView.swift
//  Example
//
//  Created by ky0me22 on 2026/05/15.
//

import KintoneAPI
import SwiftUI

struct RecordPermissionChunkView: View {
    var permissionChunk: RecordPermissionChunk

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("ID: \(permissionChunk.recordPermission.id)")
            Text(verbatim: "Viewable: \(permissionChunk.recordPermission.viewable)")
            Text(verbatim: "Editable: \(permissionChunk.recordPermission.editable)")
            Text(verbatim: "Deletable: \(permissionChunk.recordPermission.deletable)")

            if permissionChunk.fieldPermissions.isEmpty {
                CornerRadiusText("Fields: Empty")
            } else {
                HStack(alignment: .top) {
                    Text("Fields:")
                    Divider()
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(permissionChunk.fieldPermissions) { fieldPermission in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Code: \(fieldPermission.code)")
                                Text(verbatim: "Viewable: \(fieldPermission.viewable)")
                                Text(verbatim: "Editable: \(fieldPermission.editable)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadiusBorder()
                        }
                    }
                }
                .cornerRadiusBorder()
            }
        }
        .cornerRadiusBorder()
    }
}
