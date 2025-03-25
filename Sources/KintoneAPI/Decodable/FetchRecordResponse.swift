//
//  FetchRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/02/28.
//

public struct FetchRecordResponse: Sendable, Equatable {
    public var record: Record.Read
}

extension FetchRecordResponse: Decodable {
    enum CodingKeys: CodingKey {
        case record
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        record = try container.decode(Record.Read.self, forKey: .record)
    }
}
