//
//  Record+Read.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

extension Record {
    public struct Read: Decodable, Sendable, Equatable {
        public var identity: RecordIdentity.Read
        public var fields: [RecordField.Read]

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            let id = try container.customDecode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: "$id")!) { $0.integer }
            let revision = try container.customDecode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: "$revision")!) { $0.integer }
            identity = RecordIdentity.Read(id: id, revision: revision)
            let keys = container.allKeys.filter { !["$id", "$revision"].contains($0.stringValue) }
            fields = try keys.map { key in
                let value = try container.decode(RecordFieldValue.Read.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
                return RecordField.Read(code: key.stringValue, value: value)
            }
        }

        init(identity: RecordIdentity.Read, fields: [RecordField.Read]) {
            self.identity = identity
            self.fields = fields
        }
    }
}
