//
//  StatusAction.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct StatusAction: Decodable, Sendable {
    public var name: String
    public var from: String
    public var to: String
    public var filterCondition: String

    enum CodingKeys: String, CodingKey {
        case name
        case from
        case to
        case filterCondition = "filterCond"
    }
}
