//
//  KintoneAppsRequest.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

struct KintoneAppsRequest: Encodable {
    var appIDs: [Int]?
    var codes: [String]?
    var name: String?
    var spaceIDs: [Int]?
    var offset: Int?
    var limit: Int?

    enum CodingKeys: String, CodingKey {
        case appIDs = "ids"
        case codes
        case name
        case spaceIDs = "spaceIds"
        case offset
        case limit
    }
}
