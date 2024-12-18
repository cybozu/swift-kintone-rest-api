//
//  FileObject.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

public struct FileObject: Encodable, Sendable {
    public var fileKey: String

    public init(fileKey: String) {
        self.fileKey = fileKey
    }
}
