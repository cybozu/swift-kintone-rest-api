//
//  DataURL.swift
//  Example
//
//  Created by ky0me22 on 2025/01/24.
//

import SwiftUI

struct DataURL: Transferable {
    var url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .data) { data in
            SentTransferredFile(data.url)
        } importing: { received in
            Self(url: received.file)
        }
    }
}
