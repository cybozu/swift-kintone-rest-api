//
//  FetchFormLayoutResponse.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

public struct FetchFormLayoutResponse: Decodable, Sendable, Equatable {
    public var layoutChunks: [FormLayoutChunk]
    public var revision: Int

    enum CodingKeys: String, CodingKey {
        case layoutChunks = "layout"
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        layoutChunks = try container.decode([FormLayoutChunk].self, forKey: .layoutChunks)
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }

    init(layoutChunks: [FormLayoutChunk], revision: Int) {
        self.layoutChunks = layoutChunks
        self.revision = revision
    }
}
