//
//  UpdateStatusRequest.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

struct UpdateStatusRequest: Encodable {
    var appID: Int
    var recordIdentity: RecordIdentity.Write
    var action: String
    var assignee: String?

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case recordID = "id"
        case revision
        case action
        case assignee
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appID, forKey: .appID)
        try container.encode(recordIdentity.id, forKey: .recordID)
        try container.encodeIfPresent(recordIdentity.revision, forKey: .revision)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(assignee, forKey: .assignee)
    }
}
