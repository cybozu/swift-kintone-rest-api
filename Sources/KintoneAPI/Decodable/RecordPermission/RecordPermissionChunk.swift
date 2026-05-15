//
//  RecordPermissionChunk.swift
//
//
//  Created by ky0me22 on 2026/05/15.
//

import Foundation

public struct RecordPermissionChunk: Sendable, Equatable {
    public var recordPermission: RecordPermission
    public var fieldPermissions: [FieldPermission]
}

extension RecordPermissionChunk: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case record
        case fields
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.customDecode(String.self, forKey: .id) { Int($0) }
        let record = try container.decode(Record.self, forKey: .record)
        recordPermission = .init(
            id: id,
            viewable: record.viewable,
            editable: record.editable,
            deletable: record.deletable
        )
        let fieldsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .fields)
        fieldPermissions = try fieldsContainer.allKeys
            .map { key in
                let field = try fieldsContainer.decode(Field.self, forKey: .init(stringValue: key.stringValue)!)
                return FieldPermission(
                    code: key.stringValue,
                    viewable: field.viewable,
                    editable: field.editable
                )
            }
            .sorted(using: KeyPathComparator(\.code))
    }

    private struct Record: Decodable {
        public var viewable: Bool
        public var editable: Bool
        public var deletable: Bool
    }

    private struct Field: Decodable {
        public var viewable: Bool
        public var editable: Bool
    }
}
