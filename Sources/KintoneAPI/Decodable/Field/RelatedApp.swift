//
//  RelatedApp.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct RelatedApp: Decodable, Sendable, Equatable {
    public var appID: Int
    public var code: String

    enum CodingKeys: String, CodingKey {
        case appID = "app"
        case code
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appID = try container.customDecode(String.self, forKey: .appID) { Int($0) }
        code = try container.decode(String.self, forKey: .code)
    }

    init(appID: Int, code: String) {
        self.appID = appID
        self.code = code
    }
}
