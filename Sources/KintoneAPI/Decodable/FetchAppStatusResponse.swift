//
//  FetchAppStatusResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

struct FetchAppStatusResponse: Decodable {
    var appStatusSettings: AppStatusSettings

    init(from decoder: any Decoder) throws {
        appStatusSettings = try AppStatusSettings(from: decoder)
    }
}
