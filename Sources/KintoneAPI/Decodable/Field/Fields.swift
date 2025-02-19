//
//  Fields.swift
//
//
//  Created by ky0me22 on 2025/02/19.
//

public struct Fields: Decodable {
    public var properties: [FieldProperty]
    public var revision: Int

    enum CodingKeys: CodingKey {
        case properties
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let propertiesContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .properties)
        properties = try propertiesContainer.allKeys.map { key in
            try propertiesContainer.decode(FieldProperty.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
        }
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
