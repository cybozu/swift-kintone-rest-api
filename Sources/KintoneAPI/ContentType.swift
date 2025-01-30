//
//  ContentType.swift
//
//
//  Created by ky0me22 on 2025/01/21.
//

enum ContentType {
    case applicationJSON
    case multipartFormData(String)

    var value: String {
        switch self {
        case .applicationJSON:
            "application/json"
        case let .multipartFormData(boundary):
            "multipart/form-data; boundary=\(boundary)"
        }
    }
}
