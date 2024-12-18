//
//  CheckBoxData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct CheckBoxData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var options: [FieldOption]
    public var defaultValue: [String]
    public var alignment: FieldOptionAlignment

    enum CodingKeys: String, CodingKey {
        case noLabel
        case required
        case options
        case defaultValue
        case alignment = "align"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        noLabel = try container.decode(Bool.self, forKey: .noLabel)
        required = try container.decode(Bool.self, forKey: .required)
        options = try FieldOptions(from: decoder).values
        defaultValue = try container.decode([String].self, forKey: .defaultValue)
        alignment = try container.decode(FieldOptionAlignment.self, forKey: .alignment)
    }
}
