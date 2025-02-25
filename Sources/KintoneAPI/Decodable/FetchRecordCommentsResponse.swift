//
//  FetchRecordCommentsResponse.swift
//
//
//  Created by ky0me22 on 2025/02/19.
//

public struct FetchRecordCommentsResponse: Decodable, Sendable, Equatable {
    public var comments: [RecordComment.Read]
    public var older: Bool
    public var newer: Bool

    init(comments: [RecordComment.Read], older: Bool, newer: Bool) {
        self.comments = comments
        self.older = older
        self.newer = newer
    }
}
