//
//  GroupAttribute.swift
//
//
//  Created by ky0me22 on 2025/01/15.
//

public struct GroupAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var openGroup: Bool

    init(noLabel: Bool, openGroup: Bool) {
        self.noLabel = noLabel
        self.openGroup = openGroup
    }
}
