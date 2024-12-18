//
//  RecordRequest.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

struct RecordRequest: Encodable {
    var appID: Int
    var fields: [RecordField]

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case record
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appID, forKey: .appID)
        var recordContainer = container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .record)
        try fields.forEach { field in
            try recordContainer.encode(field, forKey: DynamicCodingKey(stringValue: field.code)!)
        }
    }
}
