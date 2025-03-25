//
//  CalcAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct CalcAttribute: Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var expression: String
    public var hideExpression: Bool
    public var format: CalcFormat
    public var displayScale: Int?
    public var unit: String
    public var unitPosition: UnitPosition
}

extension CalcAttribute: Decodable {
    enum CodingKeys: CodingKey {
        case noLabel
        case required
        case expression
        case hideExpression
        case format
        case displayScale
        case unit
        case unitPosition
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        expression = try container.decode(String.self, forKey: .expression)
        hideExpression = try container.decode(Bool.self, forKey: .hideExpression)
        format = try container.decode(CalcFormat.self, forKey: .format)
        displayScale = Int(try container.decode(String.self, forKey: .displayScale))
        unit = try container.decode(String.self, forKey: .unit)
        unitPosition = try container.decode(UnitPosition.self, forKey: .unitPosition)
    }
}
