//
//  TimeData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

import Foundation

public struct TimeData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var defaultNowValue: Bool
    public var defaultValue: Date

    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case defaultNowValue
        case defaultValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        defaultNowValue = try container.decode(Bool.self, forKey: .defaultNowValue)
        let _defaultValue = try container.decode(String.self, forKey: .defaultValue)
        defaultValue = DateFormatter.kintoneTime.date(from: _defaultValue.normalizedTime) ?? Date.now
    }
}
