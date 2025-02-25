//
//  FormLayoutChunk.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct FormLayoutChunk: Decodable, Sendable, Equatable {
    public var type: FormLayoutType
    public var code: String?
    public var fields: [FormField]
    public var layoutChunks: [FormLayoutChunk]

    enum CodingKeys: String, CodingKey {
        case type
        case code
        case fields
        case layoutChunks = "layout"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(FormLayoutType.self, forKey: .type)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        fields = try container.decodeIfPresent([FormField].self, forKey: .fields) ?? []
        layoutChunks = try container.decodeIfPresent([FormLayoutChunk].self, forKey: .layoutChunks) ?? []
    }

    init(type: FormLayoutType, code: String?, fields: [FormField], layoutChunks: [FormLayoutChunk]) {
        self.type = type
        self.code = code
        self.fields = fields
        self.layoutChunks = layoutChunks
    }
}
