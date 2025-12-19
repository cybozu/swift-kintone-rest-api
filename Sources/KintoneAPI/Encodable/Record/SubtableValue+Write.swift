//
//  SubtableValue+Write.swift
//
//
//  Created by ky0me22 on 2025/12/18.
//

import Foundation

extension SubtableValue {
    public struct Write: Sendable {
        public var id: Int?
        public var value: [RecordField.Write]

        public init(id: Int? = nil, value: [RecordField.Write]) {
            self.id = id
            self.value = value
        }
    }
}

extension SubtableValue.Write: Encodable {
    enum CodingKeys: CodingKey {
        case id
        case value
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id.map(String.init(describing:)), forKey: .id)
        var fieldsContainer = container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .value)
        try value.forEach { field in
            let value = SubtableFieldValue.Write(value: field.value)
            try fieldsContainer.encodeIfPresent(value, forKey: .init(stringValue: field.code)!)
        }
    }
}
