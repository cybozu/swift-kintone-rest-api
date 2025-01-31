//
//  FetchAppSettingsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

struct FetchAppSettingsResponse: Decodable {
    var appSettings: AppSettings

    init(from decoder: any Decoder) throws {
        appSettings = try AppSettings(from: decoder)
    }
}
