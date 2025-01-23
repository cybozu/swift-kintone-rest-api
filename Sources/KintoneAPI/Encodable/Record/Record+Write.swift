//
//  Record+Write.swift
//
//
//  Created by ky0me22 on 2025/01/23.
//

extension Record {
    public struct Write: Encodable, Sendable {
        public var fields: [RecordField.Write]
        
        public init(fields: [RecordField.Write]) {
            self.fields = fields
        }
        
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: DynamicCodingKey.self)
            try fields.forEach { field in
                try container.encode(field.value, forKey: DynamicCodingKey(stringValue: field.code)!)
            }
        }
    }
}
