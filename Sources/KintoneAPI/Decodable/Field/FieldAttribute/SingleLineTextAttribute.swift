//
//  SingleLineTextAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct SingleLineTextAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var minLength: Int?
    public var maxLength: Int?
    public var expression: String
    public var hideExpression: Bool
    public var unique: Bool
    public var defaultValue: String

    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case minLength
        case maxLength
        case expression
        case hideExpression
        case unique
        case defaultValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        minLength = Int(try container.decode(String.self, forKey: .minLength))
        maxLength = Int(try container.decode(String.self, forKey: .maxLength))
        expression = try container.decode(String.self, forKey: .expression)
        hideExpression = try container.decode(Bool.self, forKey: .hideExpression)
        unique = try container.decode(Bool.self, forKey: .unique)
        defaultValue = try container.decode(String.self, forKey: .defaultValue)
    }

    init(
        noLabel: Bool,
        required: Bool,
        minLength: Int?,
        maxLength: Int?,
        expression: String,
        hideExpression: Bool,
        unique: Bool,
        defaultValue: String
    ) {
        self.noLabel = noLabel
        self.required = required
        self.minLength = minLength
        self.maxLength = maxLength
        self.expression = expression
        self.hideExpression = hideExpression
        self.unique = unique
        self.defaultValue = defaultValue
    }
}
