//
//  AppView.swift
//
//
//  Created by ky0me22 on 2025/03/04.
//

public struct AppView: Decodable, Sendable, Equatable {
    public var id: Int
    public var name: String
    public var filterCondition: String
    public var sort: String
    public var index: Int
    public var type: ViewType
    public var attribute: ViewAttribute
    public var builtinType: BuiltinType?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case filterCondition = "filterCond"
        case sort
        case index
        case type
        case builtinType
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.customDecode(String.self, forKey: .id) { Int($0) }
        name = try container.decode(String.self, forKey: .name)
        filterCondition = try container.decode(String.self, forKey: .filterCondition)
        sort = try container.decode(String.self, forKey: .sort)
        index = try container.customDecode(String.self, forKey: .index) { Int($0) }
        type = try container.decode(ViewType.self, forKey: .type)
        attribute = switch type {
        case .list:
            try ViewAttribute.list(ListAttribute(from: decoder))
        case .calendar:
            try ViewAttribute.calendar(CalendarAttribute(from: decoder))
        case .custom:
            try ViewAttribute.custom(CustomAttribute(from: decoder))
        }
        builtinType = try container.decodeIfPresent(BuiltinType.self, forKey: .builtinType)
    }

    init(
        id: Int,
        name: String,
        filterCondition: String,
        sort: String,
        index: Int,
        type: ViewType,
        attribute: ViewAttribute,
        builtinType: BuiltinType?
    ) {
        self.id = id
        self.name = name
        self.filterCondition = filterCondition
        self.sort = sort
        self.index = index
        self.type = type
        self.attribute = attribute
        self.builtinType = builtinType
    }
}
