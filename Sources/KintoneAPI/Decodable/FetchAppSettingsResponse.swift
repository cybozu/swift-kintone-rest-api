//
//  FetchAppSettingsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct FetchAppSettingsResponse: Decodable, Sendable {
    public var appSettings: AppSettings

    public init(from decoder: any Decoder) throws {
        appSettings = try AppSettings(from: decoder)
    }
}
