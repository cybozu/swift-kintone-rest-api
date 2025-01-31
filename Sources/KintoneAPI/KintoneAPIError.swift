//
//  KintoneAPIError.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

import Foundation

public enum KintoneAPIError: LocalizedError {
    case invalidResponse
    case requestFailed(ErrorDetail)

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "Received an invalid response."
        case let .requestFailed(errorDetail):
            "Failed to request. \(errorDetail)"
        }
    }
}
