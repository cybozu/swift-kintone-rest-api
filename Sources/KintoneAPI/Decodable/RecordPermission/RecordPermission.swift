//
//  RecordPermission.swift
//
//
//  Created by ky0me22 on 2026/05/15.
//

public struct RecordPermission: Sendable, Equatable {
    public var id: Int
    public var viewable: Bool
    public var editable: Bool
    public var deletable: Bool
}
