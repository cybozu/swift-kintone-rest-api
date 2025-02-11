//
//  UpdateRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

struct UpdateRecordResponse: Decodable, Sendable {
    var revision: Int

    enum CodingKeys: CodingKey {
        case revision
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
