//
//  FetchRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/02/28.
//

public struct FetchRecordResponse: Decodable, Sendable, Equatable {
    public var record: Record.Read

    enum CodingKeys: CodingKey {
        case record
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        record = try container.decode(Record.Read.self, forKey: .record)
    }

    init(record: Record.Read) {
        self.record = record
    }
}
