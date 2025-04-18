//
//  LinkAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct LinkAttribute: Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var linkProtocol: LinkProtocol
    public var minLength: Int?
    public var maxLength: Int?
    public var unique: Bool
    public var defaultValue: String
}

extension LinkAttribute: Decodable {
    enum CodingKeys: String, CodingKey {
        case noLabel
        case required
        case linkProtocol = "protocol"
        case minLength
        case maxLength
        case unique
        case defaultValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        linkProtocol = try container.decode(LinkProtocol.self, forKey: .linkProtocol)
        minLength = Int(try container.decode(String.self, forKey: .minLength))
        maxLength = Int(try container.decode(String.self, forKey: .maxLength))
        unique = try container.decode(Bool.self, forKey: .unique)
        defaultValue = try container.decode(String.self, forKey: .defaultValue)
    }
}
