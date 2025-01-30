//
//  SubmitRecordResponse.swift
//
//
//  Created by ky0me22 on 2025/01/30.
//

public struct SubmitRecordResponse: Decodable, Sendable {
    public var recordID: Int
    public var revision: Int
    
    enum CodingKeys: String, CodingKey {
        case recordID = "id"
        case revision
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recordID = try container.customDecode(String.self, forKey: .recordID) { Int($0) }
        self.revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
