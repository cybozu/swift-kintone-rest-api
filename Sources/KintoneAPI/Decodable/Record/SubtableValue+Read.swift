//
//  SubtableValue+Read.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

import Foundation

extension SubtableValue {
    public struct Read: Sendable, Equatable {
        public var id: Int
        public var value: [RecordField.Read]
    }
}

extension SubtableValue.Read: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case value
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.customDecode(String.self, forKey: .id) { Int($0) }
        let valueContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .value)
        value = try valueContainer.allKeys.map { key in
            let _value = try valueContainer.decode(RecordFieldValue.Read.self, forKey: .init(stringValue: key.stringValue)!)
            return RecordField.Read(code: key.stringValue, value: _value)
        }
        .sorted(using: KeyPathComparator(\.code))
    }
}
