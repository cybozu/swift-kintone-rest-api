//
//  SubmitRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

struct SubmitRecordResponse: Decodable, Sendable {
    var recordIdentity: RecordIdentity.Read
    
    init(from decoder: any Decoder) throws {
        recordIdentity = try RecordIdentity.Read(from: decoder)
    }
}
