//
//  FetchFormLayoutResponse.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

struct FetchFormLayoutResponse: Decodable {
    var layout: [FormLayout]
    var revision: Int

    enum CodingKeys: CodingKey {
        case layout
        case revision
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        layout = try container.decode([FormLayout].self, forKey: .layout)
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }
}
