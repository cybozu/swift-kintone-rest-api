//
//  LinkData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct LinkData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var linkProtocol: LinkProtocol
    public var minLength: String
    public var maxLength: String
    public var unique: Bool
    public var defaultValue: String

    enum CodingKeys: String, CodingKey {
        case noLabel
        case required
        case linkProtocol = "protocol"
        case minLength
        case maxLength
        case unique
        case defaultValue
    }
}
