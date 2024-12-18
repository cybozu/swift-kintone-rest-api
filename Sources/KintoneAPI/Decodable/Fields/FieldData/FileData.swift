//
//  FileData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct FileData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var thumbnailSize: String
}
