//
//  FieldOption.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

import Foundation

public struct FieldOption: Sendable, Equatable {
    public var label: String
    public var index: Int
}

extension FieldOption: Decodable {
    enum CodingKeys: CodingKey {
        case label
        case index
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        index = try container.customDecode(String.self, forKey: .index) { Int($0) }
    }
}

struct FieldOptions: Decodable, Sendable {
    var values: [FieldOption]

    enum CodingKeys: CodingKey {
        case options
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.allKeys.contains(.options) {
            let optionsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .options)
            values = try optionsContainer.allKeys
                .compactMap { try optionsContainer.decodeIfPresent(FieldOption.self, forKey: .init(stringValue: $0.stringValue)!) }
                .sorted(using: KeyPathComparator(\.index))
        } else {
            values = []
        }
    }
}
