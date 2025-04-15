//
//  OrganizationSelectionAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct OrganizationSelectionAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var entities: [Entity.Read]
    public var defaultValue: [Entity.Read]
}
