//
//  RecordComment+Read.swift
//
//
//  Created by ky0me22 on 2025/02/19.
//

import Foundation

extension RecordComment {
    public struct Read: Decodable, Sendable, Equatable {
        public var id: Int
        public var text: String
        public var createdAt: Date
        public var creator: Entity.Read
        public var mentions: [Entity.Read]

        enum CodingKeys: CodingKey {
            case id
            case text
            case createdAt
            case creator
            case mentions
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.customDecode(String.self, forKey: .id) { Int($0) }
            text = try container.decode(String.self, forKey: .text)
            createdAt = try container.customDecode(String.self, forKey: .createdAt) {
                DateFormatter.kintoneDateTime.date(from: $0.normalizedDateTime)
            }
            creator = try container.customDecode(EntityValue.self, forKey: .creator) {
                Entity.Read(type: .user, code: $0.code, name: $0.name)
            }
            mentions = try container.decode([Entity.Read].self, forKey: .mentions)
        }

        init(
            id: Int,
            text: String,
            createdAt: Date,
            creator: Entity.Read,
            mentions: [Entity.Read]
        ) {
            self.id = id
            self.text = text
            self.createdAt = createdAt
            self.creator = creator
            self.mentions = mentions
        }
    }
}
