//
//  FileAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct FileAttribute: Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var thumbnailSize: Int
}

extension FileAttribute: Decodable {
    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case thumbnailSize
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        thumbnailSize = try container.customDecode(String.self, forKey: .thumbnailSize) { Int($0) }
    }
}
