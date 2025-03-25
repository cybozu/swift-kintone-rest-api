//
//  StatusAction.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct StatusAction: Sendable, Equatable {
    public var name: String
    public var from: String
    public var to: String
    public var filterCondition: String
}

extension StatusAction: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case from
        case to
        case filterCondition = "filterCond"
    }
}
