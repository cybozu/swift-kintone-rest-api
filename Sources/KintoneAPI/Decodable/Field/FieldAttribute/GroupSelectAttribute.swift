//
//  GroupSelectAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct GroupSelectAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var entities: [Entity.Read]
    public var defaultValue: [Entity.Read]

    init(noLabel: Bool, required: Bool, entities: [Entity.Read], defaultValue: [Entity.Read]) {
        self.noLabel = noLabel
        self.required = required
        self.entities = entities
        self.defaultValue = defaultValue
    }
}
