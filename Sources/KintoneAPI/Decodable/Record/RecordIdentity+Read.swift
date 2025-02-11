//
//  RecordIdentity+Read.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

extension RecordIdentity {
    public struct Read: Decodable, Sendable {
        public var id: Int
        public var revision: Int

        init(id: Int, revision: Int) {
            self.id = id
            self.revision = revision
        }

        enum CodingKeys: CodingKey {
            case id
            case revision
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.customDecode(String.self, forKey: .id) { Int($0) }
            revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
        }
    }
}
