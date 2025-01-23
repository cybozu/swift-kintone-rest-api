//
//  KintoneApp.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

import Foundation

public struct KintoneApp: Decodable, Sendable {
    public var appID: Int
    public var code: String
    public var name: String
    public var description: String
    public var spaceID: Int?
    public var threadID: Int?
    public var createdAt: Date?
    public var creator: Entity.Read
    public var modifiedAt: Date?
    public var modifier: Entity.Read

    enum CodingKeys: String, CodingKey {
        case appID = "appId"
        case code
        case name
        case description
        case spaceID = "spaceId"
        case threadID = "threadId"
        case createdAt
        case creator
        case modifiedAt
        case modifier
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appID = try container.customDecode(String.self, forKey: .appID) { Int($0) }
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        spaceID = try container.customDecodeIfPresent(String.self, forKey: .spaceID) { Int($0) }
        threadID = try container.customDecodeIfPresent(String.self, forKey: .threadID) { Int($0) }
        createdAt = try container.customDecodeIfPresent(String.self, forKey: .createdAt) {
            DateFormatter.kintoneDateTime.date(from: $0.normalizedDateTime)
        }
        creator = try container.customDecode(EntityValue.self, forKey: .creator) {
            Entity.Read(type: .user, code: $0.code, name: $0.name)
        }
        modifiedAt = try container.customDecodeIfPresent(String.self, forKey: .modifiedAt) {
            DateFormatter.kintoneDateTime.date(from: $0.normalizedDateTime)
        }
        modifier = try container.customDecode(EntityValue.self, forKey: .modifier) {
            Entity.Read(type: .user, code: $0.code, name: $0.name)
        }
    }
}
