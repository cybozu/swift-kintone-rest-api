//
//  SubmitRecordRequest.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

struct SubmitRecordRequest: Encodable {
    var appID: Int
    var record: Record.Write

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case record
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appID, forKey: .appID)
        try container.encode(record, forKey: .record)
    }
}
