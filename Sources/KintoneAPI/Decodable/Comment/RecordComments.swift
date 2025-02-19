//
//  RecordComments.swift
//
//
//  Created by ky0me22 on 2025/02/19.
//

public struct RecordComments: Decodable, Sendable {
    public var comments: [RecordComment.Read]
    public var older: Bool
    public var newer: Bool
}
