//
//  DeleteRecordsRequest.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

struct DeleteRecordsRequest: Encodable {
    var appID: Int
    var recordIdentities: [RecordIdentity.Write]

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case recordIDs = "ids"
        case revisions
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appID, forKey: .appID)
        try container.encode(recordIdentities.map(\.id), forKey: .recordIDs)
        try container.encode(recordIdentities.map({ $0.revision ?? -1 }), forKey: .revisions)
    }
}
