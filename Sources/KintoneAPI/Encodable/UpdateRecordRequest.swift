//
//  UpdateRecordRequest.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

import Foundation

struct UpdateRecordRequest: Encodable {
    var appID: Int
    var recordID: Int
    var revision: Int?
    var record: Record.Write

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case recordID = "id"
        case revision
        case record
    }
}
