//
//  CalendarAttribute.swift
//
//
//  Created by ky0me22 on 2025/03/04.
//

public struct CalendarAttribute: Sendable, Equatable {
    public var titleField: String
    public var dateField: String
}

extension CalendarAttribute: Decodable {
    enum CodingKeys: String, CodingKey {
        case titleField = "title"
        case dateField = "date"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        titleField = try container.decode(String.self, forKey: .titleField)
        dateField = try container.decode(String.self, forKey: .dateField)
    }
}
