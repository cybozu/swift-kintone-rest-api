//
//  GroupSelectData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct GroupSelectData: Decodable, Sendable {
    public var noLabel: Bool
    public var required: Bool
    public var entities: [FieldEntity]
    public var defaultValue: [FieldEntity]
}
