//
//  CustomAttribute.swift
//
//
//  Created by ky0me22 on 2025/03/04.
//

public struct CustomAttribute: Decodable, Sendable, Equatable {
    public var html: String
    public var pager: Bool
    public var device: Device
}
