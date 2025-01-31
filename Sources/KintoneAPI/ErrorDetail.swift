//
//  ErrorDetail.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct ErrorDetail: Sendable, CustomStringConvertible {
    public var statusCode: Int
    public var cybozuError: String?

    public var description: String {
        if let cybozuError {
            "[Statue Code: \(statusCode), Cybozu Error: \(cybozuError)]"
        } else {
            "[Statue Code: \(statusCode)]"
        }
    }
}
