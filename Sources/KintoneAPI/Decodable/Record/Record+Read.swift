//
//  Record+Read.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

extension Record {
    public struct Read: Decodable, Sendable {
        public var id: Int
        public var revision: Int
        public var fields: [RecordField.Read]

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            id = try container.customDecode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: "$id")!) { $0.integer }
            revision = try container.customDecode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: "$revision")!) { $0.integer }
            fields = try container.allKeys
                .filter { !["$id", "$revision"].contains($0.stringValue) }
                .map { key in
                    let value = try container.decode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
                    return RecordField.Read(code: key.stringValue, value: value)
                }
        }
    }
}
