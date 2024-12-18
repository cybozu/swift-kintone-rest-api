//
//  SingleLineTextData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct SingleLineTextData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var minLength: String
    public var maxLength: String
    public var expression: String
    public var hideExpression: Bool
    public var unique: Bool
    public var defaultValue: String
}
