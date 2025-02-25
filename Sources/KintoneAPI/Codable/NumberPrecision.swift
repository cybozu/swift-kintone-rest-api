//
//  NumberPrecision.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct NumberPrecision: Codable, Sendable, Equatable {
    public var digits: Int
    public var decimalPlaces: Int
    public var roundingMode: RoundingMode

    enum CodingKeys: CodingKey {
        case digits
        case decimalPlaces
        case roundingMode
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        digits = try container.customDecode(String.self, forKey: .digits) { Int($0) }
        decimalPlaces = try container.customDecode(String.self, forKey: .decimalPlaces) { Int($0) }
        roundingMode = try container.decode(RoundingMode.self, forKey: .roundingMode)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(digits.description, forKey: .digits)
        try container.encode(decimalPlaces.description, forKey: .decimalPlaces)
        try container.encode(roundingMode, forKey: .roundingMode)
    }

    init(digits: Int, decimalPlaces: Int, roundingMode: RoundingMode) {
        self.digits = digits
        self.decimalPlaces = decimalPlaces
        self.roundingMode = roundingMode
    }
}
