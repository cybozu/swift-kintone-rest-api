//
//  UpdateRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

public struct UpdateRecordResponse: Decodable, Sendable {
    public var revision: Int

    enum CodingKeys: CodingKey {
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
