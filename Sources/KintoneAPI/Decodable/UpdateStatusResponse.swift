//
//  UpdateStatusResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct UpdateStatusResponse: Sendable, Equatable {
    public var revision: Int
}

extension UpdateStatusResponse: Decodable {
    enum CodingKeys: CodingKey {
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
