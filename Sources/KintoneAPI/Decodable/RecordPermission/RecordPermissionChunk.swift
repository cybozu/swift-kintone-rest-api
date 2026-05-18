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
    enum CodingKeys: CodingKey {
        case id
        case record
        case fields
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.customDecode(String.self, forKey: .id) { Int($0) }
        let record = try container.decode(RecordPayload.self, forKey: .record)
        recordPermission = .init(
            id: id,
            viewable: record.viewable,
            editable: record.editable,
            deletable: record.deletable
        )
        let fieldsDictionary = try container.decode([String: FieldPayload].self, forKey: .fields)
        fieldPermissions = fieldsDictionary.map { code, field in
            FieldPermission(
                code: code,
                viewable: field.viewable,
                editable: field.editable
            )
        }
        .sorted(using: KeyPathComparator(\.code))
    }

    private struct RecordPayload: Decodable {
        public var viewable: Bool
        public var editable: Bool
        public var deletable: Bool
    }

    private struct FieldPayload: Decodable {
        public var viewable: Bool
        public var editable: Bool
    }
}
