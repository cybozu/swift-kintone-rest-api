//
//  KintoneAPIError.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

import Foundation

public enum KintoneAPIError: LocalizedError {
    case invalidResponse
    case requestFailed(Reason)

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "Received an invalid response."
        case let .requestFailed(reason):
            "Failed to request. reason: \(reason)"
        }
    }
}

extension KintoneAPIError {
    public struct Reason: Sendable, CustomStringConvertible {
        public var statusCode: Int
        public var cybozuError: String?
        public var detail: Detail?

        public var description: String {
            var items = ["statueCode: \(statusCode)"]
            if let cybozuError {
                items.append("cybozuError: \"\(cybozuError)\"")
            }
            if let detail {
                items.append("detail: \(detail)")
            }
            return "{ \(items.joined(separator: ", ")) }"
        }
    }
}
