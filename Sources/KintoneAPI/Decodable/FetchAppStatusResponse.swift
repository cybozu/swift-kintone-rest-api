//
//  FetchAppStatusResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct FetchAppStatusResponse: Decodable, Sendable {
    public var appStatusSettings: AppStatusSettings

    public init(from decoder: any Decoder) throws {
        appStatusSettings = try AppStatusSettings(from: decoder)
    }
}
