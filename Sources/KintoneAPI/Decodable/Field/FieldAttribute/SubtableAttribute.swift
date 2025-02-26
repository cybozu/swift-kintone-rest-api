//
//  SubtableAttribute.swift
//
//
//  Created by ky0me22 on 2025/01/21.
//

import Foundation

public struct SubtableAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var fields: [Field]

    enum CodingKeys: CodingKey {
        case noLabel
        case fields
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        let fieldsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .fields)
        fields = try fieldsContainer.allKeys
            .map { try fieldsContainer.decode(Field.self, forKey: .init(stringValue: $0.stringValue)!) }
            .sorted(using: KeyPathComparator(\.code))
    }

    init(
        noLabel: Bool,
        fields: [Field]
    ) {
        self.noLabel = noLabel
        self.fields = fields
    }
}
