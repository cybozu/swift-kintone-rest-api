//
//  RecordState.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct RecordState: Decodable, Sendable, Equatable {
    public var name: String
    public var index: Int
    public var assignee: Assignee

    enum CodingKeys: CodingKey {
        case name
        case index
        case assignee
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        index = try container.customDecode(String.self, forKey: .index) { Int($0) }
        assignee = try container.decode(Assignee.self, forKey: .assignee)
    }

    init(
        name: String,
        index: Int,
        assignee: Assignee
    ) {
        self.name = name
        self.index = index
        self.assignee = assignee
    }
}
