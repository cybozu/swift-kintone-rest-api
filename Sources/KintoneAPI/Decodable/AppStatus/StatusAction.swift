//
//  StatusAction.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct StatusAction: Decodable, Sendable, Equatable {
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

    init(name: String, from: String, to: String, filterCondition: String) {
        self.name = name
        self.from = from
        self.to = to
        self.filterCondition = filterCondition
    }
}
