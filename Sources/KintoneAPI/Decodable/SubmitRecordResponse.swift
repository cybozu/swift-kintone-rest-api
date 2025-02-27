//
//  SubmitRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

public struct SubmitRecordResponse: Decodable, Sendable, Equatable {
    public var recordIdentity: RecordIdentity.Read

    public init(from decoder: any Decoder) throws {
        recordIdentity = try RecordIdentity.Read(from: decoder)
    }

    init(recordIdentity: RecordIdentity.Read) {
        self.recordIdentity = recordIdentity
    }
}
