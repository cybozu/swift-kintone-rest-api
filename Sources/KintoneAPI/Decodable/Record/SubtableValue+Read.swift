//
//  SubtableValue+Read.swift
//  KintoneAPI
//
//  Created by ky0me22 on 2025/01/22.
//

import Foundation

extension SubtableValue {
    public struct Read: Decodable, Sendable {
        public var id: Int
        public var value: [RecordField.Read]

        enum CodingKeys: CodingKey {
            case id
            case value
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.customDecode(String.self, forKey: .id) { Int($0) }
            let valueContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .value)
            value = try valueContainer.allKeys.map { key in
                let _value = try valueContainer.decode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
                return RecordField.Read(code: key.stringValue, value: _value)
            }
        }
    }
}
