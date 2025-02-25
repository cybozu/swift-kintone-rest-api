//
//  FetchRecordsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

public struct FetchRecordsResponse: Decodable, Sendable, Equatable {
    public var records: [Record.Read]
    public var totalCount: Int?

    init(records: [Record.Read], totalCount: Int?) {
        self.records = records
        self.totalCount = totalCount
    }
}
