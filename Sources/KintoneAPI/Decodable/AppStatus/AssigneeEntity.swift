//
//  AssigneeEntity.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct AssigneeEntity: Sendable, Equatable {
    public var type: EntityType
    public var code: String?
    public var includeSubs: Bool
}

extension AssigneeEntity: Decodable {
    enum CodingKeys: CodingKey {
        case entity
        case type
        case code
        case includeSubs
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let entityContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .entity)
        type = try entityContainer.decode(EntityType.self, forKey: .type)
        code = try entityContainer.decodeIfPresent(String.self, forKey: .code)
        includeSubs = try container.decode(Bool.self, forKey: .includeSubs)
    }
}
