//
//  StatusAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct StatusAttribute: Decodable, Sendable, Equatable {
    public var enabled: Bool

    init(enabled: Bool) {
        self.enabled = enabled
    }
}
