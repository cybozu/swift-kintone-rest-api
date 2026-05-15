//
//  EvaluateRecordPermissionsResponse.swift
//
//
//  Created by ky0me22 on 2026/05/15.
//

public struct EvaluateRecordPermissionsResponse: Sendable, Equatable {
    public var recordPermissionChunks: [RecordPermissionChunk]
}

extension EvaluateRecordPermissionsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case recordPermissionChunks = "rights"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recordPermissionChunks = try container.decode([RecordPermissionChunk].self, forKey: .recordPermissionChunks)
    }
}
