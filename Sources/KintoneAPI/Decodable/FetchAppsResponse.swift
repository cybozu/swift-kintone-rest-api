//
//  FetchAppsResponse.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct FetchAppsResponse: Decodable, Sendable, Equatable {
    public var apps: [KintoneApp]
}
