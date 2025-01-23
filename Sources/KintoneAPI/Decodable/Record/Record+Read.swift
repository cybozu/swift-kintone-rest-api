//
//  Record+Read.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

extension Record {
    public struct Read: Decodable, Sendable {
        public var fields: [RecordField.Read]

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            fields = try container.allKeys.map { key in
                let value = try container.decode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
                return RecordField.Read(code: key.stringValue, value: value)
            }
        }
    }
}
