//
//  CalcData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct CalcData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var expression: String
    public var hideExpression: Bool
    public var format: CalcFormat
    public var displayScale: String
    public var unit: String
    public var unitPosition: UnitPosition
}
