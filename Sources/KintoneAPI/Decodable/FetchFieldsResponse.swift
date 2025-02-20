//
//  FetchFieldsResponse.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

public struct FetchFieldsResponse: Decodable, Sendable {
    public var fields: [Field]
    public var revision: Int

    enum CodingKeys: String, CodingKey {
        case fields = "properties"
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let fieldsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .fields)
        fields = try fieldsContainer.allKeys.map { key in
            try fieldsContainer.decode(Field.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
        }
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
