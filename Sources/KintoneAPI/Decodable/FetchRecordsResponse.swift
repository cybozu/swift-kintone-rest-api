//
//  FetchRecordsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

public struct FetchRecordsResponse: Sendable, Equatable {
    public var records: [Record.Read]
    public var totalCount: Int?
}

extension FetchRecordsResponse: Decodable {
    enum CodingKeys: CodingKey {
        case records
        case totalCount
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        records = try container.decode([RecordReadOrEmpty].self, forKey: .records).compactMap(\.value)
        totalCount = try container.customDecodeIfPresent(String.self, forKey: .totalCount) { Int($0) }
    }
}

// WORKAROUND: Unexpected JSON is returned if a field code that does not exist is specified.
// [] and [{}] are treated as [].
private enum RecordReadOrEmpty: Decodable {
    case record(Record.Read)
    case empty
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = if let record = try? container.decode(Record.Read.self) {
            if record.fields.isEmpty, record.identity == nil {
                .empty
            } else {
                .record(record)
            }
        } else {
            .empty
        }
    }

    var value: Record.Read? {
        switch self {
        case let .record(value): value
        case .empty: nil
        }
    }
}
