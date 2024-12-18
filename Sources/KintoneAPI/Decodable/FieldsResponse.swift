//
//  FieldsResponse.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

struct FieldsResponse: Decodable {
    var properties: [FieldProperty]

    enum CodingKeys: String, CodingKey {
        case properties
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let propertiesContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .properties)
        properties = try propertiesContainer.allKeys.map { key in
            try propertiesContainer.decode(FieldProperty.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
        }
    }
}
