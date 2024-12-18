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
    public var creator: Creator
    public var modifiedAt: Date?
    public var modifier: Modifier

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
        creator = try container.decode(Creator.self, forKey: .creator)
        modifiedAt = try container.customDecodeIfPresent(String.self, forKey: .modifiedAt) {
            DateFormatter.kintoneDateTime.date(from: $0.normalizedDateTime)
        }
        modifier = try container.decode(Modifier.self, forKey: .modifier)
    }
}

private extension KeyedDecodingContainer<KintoneApp.CodingKeys> {
    func customDecode<T, S>(
        _ type: T.Type,
        forKey key: KeyedDecodingContainer<K>.Key,
        initializer: (T) -> S?
    ) throws -> S where S: Decodable, T: Decodable {
        let rawValue = try decode(type, forKey: key)
        guard let value = initializer(rawValue) else {
            throw DecodingError.typeMismatch(Int.self, .init(
                codingPath: [key],
                debugDescription: "Failed to decode \(key)"
            ))
        }
        return value
    }

    func customDecodeIfPresent<T, S>(
        _ type: T.Type,
        forKey key: KeyedDecodingContainer<K>.Key,
        initializer: (T) -> S?
    ) throws -> S? where S: Decodable, T: Decodable {
        guard let rawValue = try decodeIfPresent(type, forKey: key) else {
            return nil
        }
        guard let value = initializer(rawValue) else {
            throw DecodingError.typeMismatch(Int.self, .init(
                codingPath: [key],
                debugDescription: "Failed to decode \(key)"
            ))
        }
        return value
    }
}
