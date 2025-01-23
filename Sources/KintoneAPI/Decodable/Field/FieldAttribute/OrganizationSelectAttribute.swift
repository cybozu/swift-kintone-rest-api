//
//  OrganizationSelectAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct OrganizationSelectAttribute: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var entities: [Entity.Read]
    public var defaultValue: [Entity.Read]
}
