//
//  NumberData.swift
//
//
//  Created by okayu on 2024/12/06.
//

public struct NumberData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var minValue: String
    public var maxValue: String
    public var digit: Bool
    public var unique: Bool
    public var defaultValue: String
    public var displayScale: String
    public var unit: String
    public var unitPosition: String
}
