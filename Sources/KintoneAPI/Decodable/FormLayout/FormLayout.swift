//
//  FormLayout.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct FormLayout: Decodable, Sendable {
    public var type: FormLayoutType
    public var code: String?
    public var fields: [FormField]
    public var layout: [FormLayout]

    enum CodingKeys: CodingKey {
        case type
        case code
        case fields
        case layout
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(FormLayoutType.self, forKey: .type)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        fields = try container.decodeIfPresent([FormField].self, forKey: .fields) ?? []
        layout = try container.decodeIfPresent([FormLayout].self, forKey: .layout) ?? []
    }
}
