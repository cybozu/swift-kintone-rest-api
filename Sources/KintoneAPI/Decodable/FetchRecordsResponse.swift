//
//  FetchRecordsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

public struct FetchRecordsResponse: Decodable, Sendable {
    public var records: [Record.Read]
}
