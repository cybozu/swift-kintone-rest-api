//
//  FieldOption.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct FieldOption: Decodable, Sendable {
    public var label: String
    public var index: String
}

struct FieldOptions: Decodable, Sendable {
    var values: [FieldOption]

    enum CodingKeys: CodingKey {
        case options
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.allKeys.contains(.options) {
            let optionsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .options)
            values = try optionsContainer.allKeys.compactMap { key in
                try optionsContainer.decodeIfPresent(FieldOption.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
            }
            .sorted(by: { $0.index < $1.index })
        } else {
            values = []
        }
    }
}
