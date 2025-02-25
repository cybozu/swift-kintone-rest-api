//
//  LookupAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct LookupAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var lookup: Lookup
}
