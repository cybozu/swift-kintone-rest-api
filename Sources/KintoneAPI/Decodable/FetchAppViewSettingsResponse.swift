//
//  FetchAppViewSettingsResponse.swift
//
//
//  Created by ky0me22 on 2025/03/04.
//

import Foundation

public struct FetchAppViewSettingsResponse: Sendable, Equatable {
    public var views: [AppView]
    public var revision: Int
}

extension FetchAppViewSettingsResponse: Decodable {
    enum CodingKeys: CodingKey {
        case views
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let viewsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .views)
        views = try viewsContainer.allKeys
            .map { try viewsContainer.decode(AppView.self, forKey: .init(stringValue: $0.stringValue)!) }
            .sorted(using: KeyPathComparator(\.id))
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
