//
//  MultiSelectAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct MultiSelectAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var options: [FieldOption]
    public var defaultValue: [String]

    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case options
        case defaultValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        options = try FieldOptions(from: decoder).values
        defaultValue = try container.decode([String].self, forKey: .defaultValue)
    }

    init(
        noLabel: Bool,
        required: Bool,
        options: [FieldOption],
        defaultValue: [String]
    ) {
        self.noLabel = noLabel
        self.required = required
        self.options = options
        self.defaultValue = defaultValue
    }
}
