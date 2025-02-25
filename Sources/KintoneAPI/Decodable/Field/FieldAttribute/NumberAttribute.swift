//
//  NumberAttribute.swift
//
//
//  Created by okayu on 2024/12/06.
//

public struct NumberAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var minValue: Int?
    public var maxValue: Int?
    public var digit: Bool
    public var unique: Bool
    public var defaultValue: String
    public var displayScale: Int?
    public var unit: String
    public var unitPosition: UnitPosition

    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case minValue
        case maxValue
        case digit
        case unique
        case defaultValue
        case displayScale
        case unit
        case unitPosition
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        minValue = Int(try container.decode(String.self, forKey: .minValue))
        maxValue = Int(try container.decode(String.self, forKey: .maxValue))
        digit = try container.decode(Bool.self, forKey: .digit)
        unique = try container.decode(Bool.self, forKey: .unique)
        defaultValue = try container.decode(String.self, forKey: .defaultValue)
        displayScale = Int(try container.decode(String.self, forKey: .displayScale))
        unit = try container.decode(String.self, forKey: .unit)
        unitPosition = try container.decode(UnitPosition.self, forKey: .unitPosition)
    }

    init(
        noLabel: Bool,
        required: Bool,
        minValue: Int?,
        maxValue: Int?,
        digit: Bool,
        unique: Bool,
        defaultValue: String,
        displayScale: Int?,
        unit: String,
        unitPosition: UnitPosition
    ) {
        self.noLabel = noLabel
        self.required = required
        self.minValue = minValue
        self.maxValue = maxValue
        self.digit = digit
        self.unique = unique
        self.defaultValue = defaultValue
        self.displayScale = displayScale
        self.unit = unit
        self.unitPosition = unitPosition
    }
}
