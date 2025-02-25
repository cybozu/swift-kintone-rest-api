//
//  FetchAppStatusSettingsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

import Foundation

public struct FetchAppStatusSettingsResponse: Decodable, Sendable, Equatable {
    public var enable: Bool
    public var states: [RecordState]
    public var actions: [StatusAction]
    public var revision: Int

    enum CodingKeys: CodingKey {
        case enable
        case states
        case actions
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        enable = try container.decode(Bool.self, forKey: .enable)
        if try container.decodeNil(forKey: .states) {
            states = []
        } else {
            let statesContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .states)
            states = try statesContainer.allKeys.map { key in
                try statesContainer.decode(RecordState.self, forKey: DynamicCodingKey(stringValue: key.stringValue)!)
            }
            .sorted(using: KeyPathComparator(\.index))
        }
        actions = try container.decodeIfPresent([StatusAction].self, forKey: .actions) ?? []
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }

    init(
        enable: Bool,
        states: [RecordState],
        actions: [StatusAction],
        revision: Int
    ) {
        self.enable = enable
        self.states = states
        self.actions = actions
        self.revision = revision
    }
}
