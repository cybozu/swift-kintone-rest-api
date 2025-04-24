//
//  Record+Read.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

import Foundation

extension Record {
    public struct Read: Sendable, Equatable {
        public var identity: RecordIdentity.Read?
        public var fields: [RecordField.Read]
    }
}

extension Record.Read: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        fields = try container.allKeys.map { key in
            RecordField.Read(
                code: key.stringValue,
                value: try container.decode(RecordFieldValue.Read.self, forKey: .init(stringValue: key.stringValue)!)
            )
        }
        .sorted(using: KeyPathComparator(\.code))

        identity = if let id = fields.first(where: { $0.code == "$id" })?.value.integer,
                      let revision = fields.first(where: { $0.code == "$revision" })?.value.integer {
            RecordIdentity.Read(id: id, revision: revision)
        } else {
            nil
        }
    }
}
