//
//  DateData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

import Foundation

public struct DateData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var unique: Bool
    public var defaultNowValue: Bool
    public var defaultValue: Date?

    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case unique
        case defaultNowValue
        case defaultValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        unique = try container.decode(Bool.self, forKey: .unique)
        defaultNowValue = try container.decode(Bool.self, forKey: .defaultNowValue)
        let _defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
        defaultValue = if let _defaultValue {
            DateFormatter.kintoneDate.date(from: _defaultValue)
        } else {
            nil
        }
    }
}
