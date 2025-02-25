//
//  Assignee.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct Assignee: Decodable, Sendable, Equatable {
    public var type: AssigneeType
    public var entities: [AssigneeEntity]
}
