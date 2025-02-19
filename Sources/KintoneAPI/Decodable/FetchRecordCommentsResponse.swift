//
//  FetchRecordCommentsResponse.swift
//
//
//  Created by ky0me22 on 2025/02/19.
//

struct FetchRecordCommentsResponse: Decodable {
    var recordComments: RecordComments

    init(from decoder: any Decoder) throws {
        recordComments = try RecordComments(from: decoder)
    }
}
