//
//  UpdateRecordRequest.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

struct UpdateRecordRequest: Encodable {
    var appID: Int
    var recordIdentity: RecordIdentity.Write
    var record: Record.Write

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case recordID = "id"
        case revision
        case record
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appID, forKey: .appID)
        try container.encode(recordIdentity.id, forKey: .recordID)
        try container.encodeIfPresent(recordIdentity.revision, forKey: .revision)
        try container.encode(record, forKey: .record)
    }
}
