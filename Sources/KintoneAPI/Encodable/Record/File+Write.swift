//
//  File+Write.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

extension File {
    public struct Write: Encodable, Sendable {
        public var fileKey: String

        public init(fileKey: String) {
            self.fileKey = fileKey
        }
    }
}
