//
//  File+Write.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

extension File {
    public struct Read: Sendable, Equatable {
        public var fileKey: String
        public var mimeType: String
        public var fileName: String
        public var fileSize: String
    }
}

extension File.Read: Decodable {
    enum CodingKeys: String, CodingKey {
        case fileKey
        case mimeType = "contentType"
        case fileName = "name"
        case fileSize = "size"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fileKey = try container.decode(String.self, forKey: .fileKey)
        mimeType = try container.decode(String.self, forKey: .mimeType)
        fileName = try container.decode(String.self, forKey: .fileName)
        fileSize = try container.decode(String.self, forKey: .fileSize)
    }
}
